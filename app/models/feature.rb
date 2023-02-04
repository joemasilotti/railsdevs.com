class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :badge_filter
      !Rails.env.production?
    when :redesign
      ENV.fetch("REDESIGN", false)
    else
      raise "Unknown feature name: #{feature_name}"
    end
  end
end
