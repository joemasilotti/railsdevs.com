class Feature
  def self.enabled?(feature_name, user:)
    case feature_name.to_sym
    when :new_developer_fields_banner
      true
    when :message_read_indicator
      true
    when :pricing_v2
      true
    when :reply_via_email
      !Rails.env.production? || user&.admin?
    end
  end
end
