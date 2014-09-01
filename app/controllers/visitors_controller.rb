class VisitorsController < ApplicationController

	def new

		@owner = Owner.new

		flash.now[:notice] = 'Welcome to the new site!'
		flash.now[:alert] = 'My birthday is soon!'


	end

end