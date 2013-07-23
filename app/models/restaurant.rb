class Restaurant < ActiveRecord::Base
	has_many :votes

	validates :yelp_id,
		presence: true,
		uniqueness: true
end
