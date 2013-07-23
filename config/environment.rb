require File.expand_path('../application', __FILE__)

Rails.logger = Logger.new(STDOUT)

GrubVote::Application.initialize!
