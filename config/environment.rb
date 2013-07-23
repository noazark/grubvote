require File.expand_path('../application', __FILE__)

Rails.logger = Logger.new(STDOUT)

GrubVote::Application.initialize!

Rails.application.routes.default_url_options[:host] = ENV['HOST']