class InviteDecorator < Draper::Decorator
	decorates_association :grub_session
	decorates_association :user
	delegate :vote, :email

	def name
		email or user.email
	end

	def inviter?
		model.grub_session.inviter == model.user
	end

	def actions
		text = "#{vote_link}"
		text << " or #{close_poll_link}" if inviter?
		text.html_safe
	end

	def vote_link
		h.link_to 'vote', h.vote_path(model)
	end

	def voted_class
		if vote then 'success' else 'secondary' end
	end

	def close_poll_link
		h.link_to 'close poll', h.close_grub_session_path(model.grub_session), method: :post
	end

	def invite_summary
		"#{grub_session.inviter} #{grub_session.guests_summary}"
	end
end