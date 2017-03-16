class BookLoansController < ApplicationController
	def new

		# byebug
		isbn = params[:"isbn"]
		@book = Book.find(isbn)
		bookloan = BookLoan.new()
		if params.has_key?("borrower_id")
			@card_id = params[:"borrower_id"]
			bookloan.card_id = @card_id
		end

		currentBorrowedBooks = Integer(BookLoan.where(:card_id => @card_id, :date_in =>  nil).count)

		if currentBorrowedBooks >= 3
			@borrowSuccessful = false
			return
		end
		
		
		bookloan.date_out = Date.today()
		bookloan.due_date = Date.today() + 14.days
		bookloan.isbn = isbn
		bookloan.save

		@book = Book.find(isbn)
		@book.update(availability: false)

		@borrowSuccessful = true
	end


	def index
		@isEmpty = false
		@borrower_search_text = params[:"borrower-search-text"]
		@borrowerInfo = BookLoan.joins("INNER JOIN borrower ON borrower.card_id = book_loans.card_id where (book_loans.card_id = '#{@borrower_search_text}' or borrower.bname like '%#{@borrower_search_text}%' or isbn = '#{@borrower_search_text}') and book_loans.date_in is null")
		.select("book_loans.*, borrower.bname as borrowerName")
		if @borrowerInfo.empty?
			@isEmpty = true
		end
	end

	def show
		@book_loan = BookLoan.find(params[:id])
		@book_loan.update(date_in: Date.today())
		book = Book.find(@book_loan.isbn)
		book.update(availability: true)


	end
end

