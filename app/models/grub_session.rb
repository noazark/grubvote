class GrubSession < ActiveRecord::Base
	has_many :invites, dependent: :destroy
	has_many :votes, through: :invites
	belongs_to :decision, class_name: 'Restaurant'
	belongs_to :inviter, class_name: 'User'
	attr_reader :invite_emails

	before_validation :generate_token

	def closed?
		decision_id?
	end

	def invite_emails=(emails)
		emails_array = emails.split(',')

		emails_array.map do |email|
			user = User.find_by_email(email)
			invite = Invite.create!(grub_session: self, email: email, user: user)
			invite.id
		end
	end

	def to_param
		token
	end

private

	def generate_token
		self.token ||= KeyGenerator.generate(8)
	end
end
