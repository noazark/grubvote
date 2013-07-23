class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def not_authenticated
		redirect_to login_path
	end

	def current_user
		UserDecorator.decorate(super) unless super == false
	end
end
