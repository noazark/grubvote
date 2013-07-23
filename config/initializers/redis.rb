redis_url = ENV['REDISCLOUD_URL'] || 'http://127.0.0.1:6379/'

environment_name = "grub_vote"
environment_name += "_#{Rails.env}" if not ENV['RACK']

Redis.current = Redis::Namespace.new(environment_name, redis: Redis.new(url: redis_url))