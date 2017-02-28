class BookLoan < ActiveRecord::Base

    self.primary_key = :loan_id

    belongs_to :book, :class_name => 'Book', :foreign_key => :isbn
    belongs_to :borrower, :class_name => 'Borrower', :foreign_key => :card_id
    has_many :fines, :class_name => 'Fine', :foreign_key => :loan_id
end
