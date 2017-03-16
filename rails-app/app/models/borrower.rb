class Borrower < ActiveRecord::Base
    self.table_name = 'borrower'
    self.primary_key = :card_id

    has_many :book_loans, :class_name => 'BookLoan', :foreign_key => :card_id

    validates :bname, presence: true
    validates :address, presence: true
    validates :ssn, presence: true, uniqueness: true
end
