Sidekiq.configure_server do |config|
  config.redis = { url: ENV['redis_uri'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['redis_uri'] }
end
