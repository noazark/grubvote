class UserSessionsController < ApplicationController
	def new
	end

	def destroy
		logout
		redirect_to root_path, :notice => 'Logged out!'
	end
end
