# Ensure non-development environments don't use dummy Stripe price IDs in config/subscriptions.yml.
unless Rails.env.development?
  subscriptions = Rails.configuration.subscriptions
  if subscriptions.values.any? { |s| s[:price_id].include?("_dummy_") }
    raise StripePriceIDsMissing.new("Stripe price IDs haven't been added to credentials for this environment.")
  end
end
