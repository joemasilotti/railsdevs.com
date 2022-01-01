class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :notifications
      !Rails.env.production?
    end
  end
end
