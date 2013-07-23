class RestaurantsController < ApplicationController
	respond_to :json

	def index
		unless params[:q].nil?
			restaurants = Restaurant.where("LOWER(name) like LOWER('?%')", "#{params[:q]}")
			respond_with restaurants
		else
			respond_with []
		end
	end
end
