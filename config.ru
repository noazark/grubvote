# This file is used by Rack-based servers to start the application.

# fix forman logging
$stdout.sync = true

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
