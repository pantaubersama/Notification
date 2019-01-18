$redis     = Redis.new(url: ENV['REDIS_SERVER_URL'])
redis_conn = proc {
  $redis
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

