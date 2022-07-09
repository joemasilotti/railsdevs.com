Tarpon::Client.configure do |c|
  c.public_api_key = Rails.application.credentials.revenue_cat.public_key
  c.secret_api_key = Rails.application.credentials.revenue_cat.private_key
  c.timeout = 5
end
