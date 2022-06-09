class Feature
  def self.enabled?(feature_name, user:)
    case feature_name.to_sym
    when :new_developer_fields_banner
      true
    when :pricing_v2
      true
    end
  end
end
