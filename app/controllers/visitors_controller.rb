class VisitorsController < ApplicationController

	def new

		@visitor = Visitor.new


	end


	def create
		@visitor = Visitor.new(secure_params)
		if @visitor.valid?
			@visitor.suscribe
			flash[:notice] = "Youve signed up with #{@visitor.email}."
			redirect_to root_path
		else
			render :new
		end
	end


	private 
	def secure_params
		params.required(:visitor).permit(:email)
	end

end