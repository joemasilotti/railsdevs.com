Hashid::Rails.configure do |config|
  salt = Rails.application.credentials.dig(:hashid, :salt)
  raise "Missing hashid salt in production!" if salt.blank? && Rails.env.production?

  config.salt = salt
  config.min_hash_length = 8
end
