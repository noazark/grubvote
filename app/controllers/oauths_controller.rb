class OauthsController < ApplicationController
	skip_before_filter :require_login

	def oauth
		login_at(params[:provider])
	end

	def callback
		provider = params[:provider]
		if @user = login_from(provider)
			redirect_to grub_sessions_path
		else
			begin
				@user = create_from(provider)

				reset_session
				auto_login(@user)
				redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
			rescue
				redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
			end
		end
	end
end