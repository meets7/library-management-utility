class BorrowersController < ApplicationController
	def new
		@borrower = Borrower.new
	end

	def create
		@borrower = Borrower.new(user_params)

  		if @borrower.save
    		redirect_to welcome_search_path
  		else
    		render 'new'
  		end
	end

	private
	def user_params
    	params.require(:borrower).permit(:bname, :ssn, :address, :phone)
  	end
end
