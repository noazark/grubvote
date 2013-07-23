class RestaurantDecorator < Draper::Decorator
	def link
		h.link_to(model.name, model.yelp_url)
	end
end