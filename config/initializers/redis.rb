url = URI.parse(ENV.fetch("REDISTOGO_URL") { "redis://localhost:6379/1" })
REDIS = Redis.new(url: url)
