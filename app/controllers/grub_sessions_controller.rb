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

		invite_emails = GrubSessionMailer.bulk_invite(grub_session.invites)
		GrubSessionMailer.deliver_builk_mail(invite_emails)

		personal_invite = grub_session.invites.create(
			user: current_user,
			email: current_user.email
		)

		redirect_to vote_path(personal_invite)
	end

	def close
		grub_session = current_user.grub_sessions.find_by_token!(params[:id])
		grub_session.close

		voting_closed_emails = GrubSessionMailer.bulk_voting_closed(grub_session.invites)
		GrubSessionMailer.deliver_builk_mail(voting_closed_emails)

		redirect_to :grub_sessions
	end

private

	def invite_params
		params.require(:grub_session).permit(:invite_emails)
	end
end