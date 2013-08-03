class GrubSessionsController < ApplicationController
	decorates_assigned :invites

	def index
		@invites = current_user.invites.recent
	end

	def new
		@grub_session = GrubSession.new
	end

	def create
		grub_session = current_user.grub_sessions.create(invite_params)

		voting = Voting.new(grub_session)
		voting.open

		redirect_to vote_path(voting.inviter_invite)
	end

	def close
		grub_session = current_user.grub_sessions.find_by_token!(params[:id])

		voting = Voting.new(grub_session)
		voting.close

		redirect_to :grub_sessions
	end

private

	def invite_params
		params.require(:grub_session).permit(:invite_emails)
	end
end