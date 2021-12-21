class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :messaging
      true
    when :pricing
      true
    else
      true
    end
  end
end
