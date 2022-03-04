class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :new_developer_fields_banner
      !Rails.env.production?
    end
  end
end
