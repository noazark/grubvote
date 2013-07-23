class FriendsController < ApplicationController
	respond_to :json

	def index
		params.require(:q)
		respond_with []
	end
end
