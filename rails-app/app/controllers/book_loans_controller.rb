class BookLoansController < ApplicationController
	def new

		bookloan = BookLoan.new()
		if params.has_key?("borrower_id")
			@card_id = params[:"borrower_id"]
			bookloan.card_id = @card_id
		end
		
		isbn = params[:"isbn"]
		bookloan.date_out = Date.today()
		bookloan.due_date = Date.today() + 14.days
		bookloan.isbn = isbn
		bookloan.save

		@book = Book.find(isbn)
		@book.availability = false
		@book.save
	end
end

