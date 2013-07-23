class GrubSessionDecorator < Draper::Decorator
	decorates_association :invites
	decorates_association :decision
	delegate :closed?

	def inviter
		if model.inviter.email === h.current_user.model.email
			'you'
		else
			model.inviter.email
		end
	end

	def guests_summary
		"invited #{h.pluralize(model.invites.count - 1, "other")}"
	end

	def decision_summary
		"the group voted for #{decision.link}".html_safe
	end
end