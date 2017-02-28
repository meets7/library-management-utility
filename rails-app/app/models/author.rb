class Author < ActiveRecord::Base

    self.primary_key = :author_id

    has_many :book_authors, :class_name => 'BookAuthor', :foreign_key => :author_id
    has_many :book_authors, :class_name => 'BookAuthor'
    has_many :book_authors, :class_name => 'BookAuthor'
end
