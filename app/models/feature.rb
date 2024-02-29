class Feature
  ENABLED_FEATURES = {
    badge_filter: !Rails.env.production?,
    business_welcome_email: true,
    cancel_subscription: true,
    developer_specialties: !Rails.env.production?,
    offer_extending: !Rails.env.production?,
    redesign: ENV.fetch("REDESIGN", false)
  }.freeze

  def self.enabled?(feature_name)
    feature_sym = feature_name.to_sym

    raise "Unknown feature name: #{feature_name}" unless ENABLED_FEATURES.include?(feature_sym)

    ENABLED_FEATURES[feature_sym]
  end
end
