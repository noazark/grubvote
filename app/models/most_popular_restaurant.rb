class MostPopularRestaurant
	def self.find(votes)
		ids = votes.map(&:restaurant_id)

		freq = ids.inject(Hash.new(0)) do |h,v|
			h[v] += 1
			h
		end

		most_popular = ids.sort_by do |v|
			freq[v]
		end.last

		Restaurant.find most_popular
	end
end