class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :messaging, :pricing
      !Rails.env.production?
    else
      true
    end
  end
end
