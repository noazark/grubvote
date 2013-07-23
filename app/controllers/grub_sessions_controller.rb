class GrubSessionsController < ApplicationController
	def index
		@invites = current_user.invites
	end

	def new
		@grub_session = GrubSession.new
	end

	def create
		grub_session = current_user.grub_sessions.create(invite_params)

		invite_emails = grub_session.invites.map do |invite|
			GrubSessionMailer.invite(invite)
		end
		deliver_builk_mail(invite_emails)

		personal_invite = grub_session.invites.create(
			user: current_user,
			email: current_user.email
		)

		redirect_to vote_path(personal_invite)
	end

	def close
		grub_session = current_user.grub_sessions.find_by_token!(params[:id])
		grub_session.update_attribute :decision,
			grub_session
				.votes
				.sample
				.restaurant

		voting_closed_emails = grub_session.invites.map do |invite|
			GrubSessionMailer.voting_closed(invite)
		end
		deliver_builk_mail(voting_closed_emails)

		redirect_to :grub_sessions
	end

private

	def invite_params
		params.require(:grub_session).permit(:invite_emails)
	end

	def deliver_builk_mail(mail)
		if GrubSessionMailer.delivery_method === :postmark
			client = Postmark::ApiClient.new(ENV['POSTMARK_API_KEY'])
			client.deliver_messages mail
		else
			mail.each(&:deliver)
		end
	end
end