class VotesController < ApplicationController
	before_filter :require_login

	def show
		@invite = Invite.find_by_token! params[:id]
	end

	def update
		invite = Invite.find_by_token params[:id]
		vote = invite.create_vote(vote_params)

		unless invite.user_id?
			invite.user = current_user
			invite.save
		end

		if current_user.email.nil?
			current_user.update_attribute :email, invite.email
		end

		redirect_to :grub_sessions
	end

private

	def vote_params
		params
			.require(:invite)
			.require(:vote)
			.permit(:restaurant_id)
	end
end