class BookAuthor < ActiveRecord::Base

    self.primary_key = :["author_id", "isbn"]

    belongs_to :author, :class_name => 'Author', :foreign_key => :author_id
    belongs_to :author, :class_name => 'Author', :foreign_key => :author_id2
    belongs_to :author, :class_name => 'Author', :foreign_key => :author_id3
    belongs_to :book, :class_name => 'Book', :foreign_key => :isbn
end
