require './app/mailers/concerns/delivers_bulk_mail'

class GrubSessionMailer < ActionMailer::Base
	include DeliversBulkMail
	default from: "monster@grubveto.com"

	def invite(invite)
		@invite = invite
		mail(
			to: invite.email,
			tag: 'invite'
		)
	end

	def self.bulk_invite(invites)
		invites.map do |invite|
			invite invite
		end
	end

	def voting_closed(invite)
		@invite = invite
		mail(
			to: invite.email,
			tag: 'invite'
		)
	end

	def self.bulk_voting_closed(invites)
		invites.map do |invite|
			voting_closed invite
		end
	end
end
