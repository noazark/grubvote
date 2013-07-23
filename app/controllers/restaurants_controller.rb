class RestaurantsController < ApplicationController
	include Searchable
	respond_to :json
end
