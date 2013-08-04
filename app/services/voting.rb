class Voting
	attr_reader :inviter_invite

	def initialize(grub_session)
		@grub_session = grub_session
	end

	def open(should_deliver=true)
		deliver_open if should_deliver
		@inviter_invite = @grub_session.invites.create(
			user: @grub_session.inviter,
			email: @grub_session.inviter.email
		)
	end

	def deliver_open
		invite_emails = GrubSessionMailer.bulk_invite(@grub_session.invites)
		GrubSessionMailer.deliver_builk_mail(invite_emails)
	end

	def close(should_deliver=true)
		unless @grub_session.closed?
			popularity = Popularity.new(@grub_session.votes, :restaurant)
			@grub_session.update_attribute :decision, popularity.most_popular
		end

		deliver_close if should_deliver
	end

	def deliver_close
		voting_closed_emails = GrubSessionMailer.bulk_voting_closed(@grub_session.invites)
		GrubSessionMailer.deliver_builk_mail(voting_closed_emails)
	end
end