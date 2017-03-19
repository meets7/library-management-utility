class BookLoansController < ApplicationController
	def new

		# byebug
		@borrowSuccessful = false
		isbn = params[:"isbn"]
		@book = Book.find(isbn)
		bookloan = BookLoan.new()
		if params.has_key?("borrower_id") and params[:"borrower_id"].present?
			@card_id = params[:"borrower_id"]
			bookloan.card_id = @card_id
		else
			flash[:error] = "Borrower Id not given."
			return redirect_to book_path id: isbn
		end

		currentBorrowedBooks = Integer(BookLoan.where(:card_id => @card_id, :date_in =>  nil).count)

		if currentBorrowedBooks >= 3
			flash[:error] = "Book limit reach. Borrower already has 3 books checked out."
			return
		end

		if BookLoan.exists?(:isbn => isbn)
			flash[:error] = "Book is already checked out."
			return
		end
		
		bookloan.date_out = Date.today()
		bookloan.due_date = Date.today() + 14.days
		bookloan.isbn = isbn
		bookloan.save

		@book = Book.find(isbn)
		@book.update(availability: false)

		@borrowSuccessful = true
		@card_id = @card_id.to_s.rjust(6, padstr='0')
	end


	def index
		@isEmpty = false
		@borrower_search_text = params[:"borrower-search-text"]
		@borrowerInfo = BookLoan.joins("INNER JOIN borrower ON borrower.card_id = book_loans.card_id INNER JOIN book on book.isbn = book_loans.isbn where (book_loans.card_id = '#{@borrower_search_text}' or borrower.bname like '%#{@borrower_search_text}%' or book_loans.isbn = '#{@borrower_search_text}') and book_loans.date_in is null")
		.select("book_loans.*, borrower.bname as borrowerName, borrower.card_id as card_id, book.title as booktitle")
		if @borrowerInfo.empty?
			@isEmpty = true
			return
		end
		@card_id = @borrowerInfo[0].card_id.to_s.rjust(6, padstr='0')
	end

	def show
		@book_loan = BookLoan.find(params[:id])
		@book_loan.update(date_in: Date.today())
		book = Book.find(@book_loan.isbn)
		book.update(availability: true)

	end
end

