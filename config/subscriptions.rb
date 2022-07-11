def stripe_price_id(subscription)
  credentials = Rails.application.credentials
  if Rails.env.development?
    credentials.dig(:stripe, :price_ids, subscription) ||
      "#{subscription}_dummy_stripe_price_id"
  else
    credentials.stripe[:price_ids][subscription]
  end
end

def revenue_cat_product_identifier(subscription)
  credentials = Rails.application.credentials
  if Rails.env.development?
    credentials.dig(:revenue_cat, :product_identifiers, subscription) ||
      "#{subscription}_dummy_revenue_cat_product_identifier"
  else
    credentials.revenue_cat[:product_identifiers][subscription]
  end
end
