class GrubSessionMailer < ActionMailer::Base
	default from: "monster@grubveto.com"

	def invite(invite)
		@invite = invite
		mail(
			to: invite.email,
			tag: 'invite'
		)
	end

	def voting_closed(invite)
		@invite = invite
		mail(
			to: invite.email,
			tag: 'invite'
		)
	end
end
