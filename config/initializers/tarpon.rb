Tarpon::Client.configure do |c|
  c.public_api_key = Rails.application.credentials.dig(:revenue_cat, :public_key)
  c.secret_api_key = Rails.application.credentials.dig(:revenue_cat, :private_key)
  c.timeout = 5
end
