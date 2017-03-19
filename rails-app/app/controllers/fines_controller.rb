class FinesController < ApplicationController
	def index
		overdueLoans = BookLoan.where ("date_in > due_date or date_in is null")

		overdueLoans.each do |loan|
			isExistingFine = Fine.exists?(loan_id: loan.loan_id)
			if  isExistingFine == false then
				newFine = Fine.new()
				newFine.loan_id = loan.loan_id
				if loan.date_in.nil? then
					if (Date.today() > loan.due_date) then
						newFine.fine_amt = (Date.today() - loan.due_date)*0.25
					else
						next
					end
				else
					newFine.fine_amt = (loan.date_in - loan.due_date)*0.25
				end
				newFine.paid = false
				newFine.save
			else
				existingFine = Fine.find_by_loan_id(loan.loan_id)
				if existingFine.paid == true then
					next
				end
				if loan.date_in.nil? then
					if (Date.today() > loan.due_date) then
						fineAmount = (Date.today() - loan.due_date)*0.25
					end
				else
					fineAmount = (loan.date_in - loan.due_date)*0.25
				end
				existingFine.update(fine_amt: fineAmount)
			end 
		end
		
		@fines = Fine.joins("INNER JOIN book_loans on fines.loan_id = book_loans.loan_id INNER JOIN borrower on borrower.card_id = book_loans.card_id where fines.paid = false group by borrower.card_id")
					 .select("borrower.card_id as card_id, borrower.bname as bname, sum(fines.fine_amt) as amount")
		
	end

	def edit
		@borrower = Borrower.find(params[:borrower_id])
		card_id = @borrower.card_id
		@fines = Fine.joins("INNER JOIN book_loans on book_loans.loan_id = fines.loan_id where fines.paid = false and book_loans.card_id = '#{card_id}'")
						 .select("fines.*, book_loans.isbn as isbn")
		@card_id = card_id.to_s.rjust(6, padstr='0')

	end

	def update
		loan_id = params[:id]
		current_fine = Fine.find(loan_id)
		bookloan = BookLoan.find(loan_id)
		if bookloan.date_in.nil?
			flash[:fineError] = "Book not checked in."
			return redirect_to action: "index"	
		end
		current_fine.update(:paid => true)
		@card_id = @card_id.to_s.rjust(6, padstr='0')
		redirect_to action: "index"

	end
end
