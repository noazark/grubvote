require 'rubygems'
require 'oauth'
require 'open-uri'
require 'pp'

require './db/seeds/restaurants'

consumer_key = 'l8gQ5H0ny4tWl4yQbKNTdw'
consumer_secret = 'Cyw79dc1YDAZpYVBJO39g8enC6k'
token = 'Nyzq7D94E4pUcgBiWmxd2B78nIau7Pua'
token_secret = 'pvVlCalgqtNrun5a04hthH53MoE'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
@access_token = OAuth::AccessToken.new(consumer, token, token_secret)

def get_restaurants(location="94105", page=1, limit=20)
	offset = page * limit

	path = URI::encode("/v2/search?term=lunch&location=#{location}&limit=20&offset=#{offset}")

	puts "requesting page #{page}"
	request = @access_token.get(path)
	response = JSON.parse(request.body, :symbolize_names => true)

	if response[:error]
		p response
	else
		response
	end
end

namespace :db do
	desc 'Generate the seed file necessary to populate the database with restaurants'
	task :generate_restaurant_seeds do
		initial_request = get_restaurants("San Francisco")
		pages = (initial_request[:total] / 20).to_i
		pages_max = 49

		pages = pages_max if pages > pages_max

		yelp = []
		yelp.concat initial_request[:businesses]

		(2..pages).each do |page|
			restaurants = get_restaurants("San Francisco", page)[:businesses]
			yelp.concat restaurants unless restaurants.nil?
		end

		yelp = yelp.map do |business|
			{
				name: business[:name],
				description: business[:snippet_text],
				cross_streets: business[:location][:cross_streets],
				address: business[:location][:address].join(', '),
				city: business[:location][:city],
				state_code: business[:location][:state_code],
				postal_code: business[:location][:postal_code],
				yelp_id: business[:id],
				yelp_rating: business[:rating],
				yelp_url: business[:url]
			}
		end

		yelp.concat YELP

		unless Dir.exist?(Rails.root.join('db', 'seeds'))
			Dir.mkdir(Rails.root.join('db', 'seeds'))
		end

		File.open(Rails.root.join('db','seeds','restaurants.rb'), 'w') do |f|
			f.write("# encoding: UTF-8\n\r\n\r")
			f.write("YELP = ")
			PP.pp(yelp, f)
		end
	end
end