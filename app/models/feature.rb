class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :obfuscate_developer_urls
      !Rails.env.production?
    end
  end
end
