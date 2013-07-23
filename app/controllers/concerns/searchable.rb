module Searchable
	extend ActiveSupport::Concern

	def index
		search
	end

	def search
		unless params[:q].nil?
			results = controller_name.classify.constantize
				.where("LOWER(name) like LOWER('#{params[:q]}%')")

			respond_with results
		else
			respond_with []
		end
	end
end