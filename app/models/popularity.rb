class Popularity
	def initialize(elements, key, options={})
		@elements = elements
		@key = key
		@key_id = options[:foreign_key] || key.to_s + '_id'
		@values = elements.map(&key)
	end

	def tally
		@_tally ||= @values.inject(Hash.new(0)) do |h,v|
			h[v] += 1
			h
		end
	end

	def popular
		@_popular ||= @values.sort_by do |element|
			tally[element.id]
		end
	end

	def most_popular
		popular.last
	end

	def least_popular
		popular.first
	end
end