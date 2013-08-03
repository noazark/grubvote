require 'key_generator'

class Invite < ActiveRecord::Base
	belongs_to :grub_session
	belongs_to :user
	has_one :vote

	before_validation :generate_token

	def self.recent
		where("created_at >= ?", Time.now - 24.hours)
			.order("created_at DESC")
	end

	def email=(value)
		user = User.find_by_email(value)
		self.user = user
		write_attribute(:email, value)
	end

	def to_param
		token
	end

private

	def generate_token
		self.token ||= KeyGenerator.generate(8)
	end
end
