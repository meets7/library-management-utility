class Book < ActiveRecord::Base
    self.table_name = 'book'
    self.primary_key = :isbn

    has_many :book_authors, :class_name => 'BookAuthor', :foreign_key => :isbn
    has_many :book_loans, :class_name => 'BookLoan', :foreign_key => :isbn
end
