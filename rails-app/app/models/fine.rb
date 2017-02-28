class Fine < ActiveRecord::Base

    self.primary_key = :loan_id

    belongs_to :book_loan, :class_name => 'BookLoan', :foreign_key => :loan_id
end
