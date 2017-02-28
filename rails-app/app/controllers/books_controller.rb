class BooksController < ApplicationController
	def index
		@search_text = params[:"search-text"]
		@books = Book.joins("INNER JOIN book_authors ON book_authors.isbn = book.isbn INNER JOIN authors on authors.author_id = book_authors.author_id where book.title like '%#{@search_text}%' or authors.name like '%#{@search_text}%' or book.isbn like '%#{@search_text}%'")
				     .select("book.*, authors.name as authorName")
	end

	def show
		@isbn = params[:"id"]
		@book = Book.find(@isbn)
	end
end
