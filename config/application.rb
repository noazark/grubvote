require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module GrubVote
	class Application < Rails::Application
		config.autoload_paths += %W(#{config.root}/app/services)
	end
end
