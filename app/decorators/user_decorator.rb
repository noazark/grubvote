class UserDecorator < Draper::Decorator
	delegate :email, :invites

	def formal
		unless model.email.blank?
			model.email
		else
			'Welcome back'
		end
	end
end