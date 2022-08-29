$redis = Redis.new( # rubocop:disable Style/GlobalVars
  url: ENV["REDIS_URL"],
  ssl_params: {verify_mode: OpenSSL::SSL::VERIFY_NONE}
)
