module UrlAttribute
  extend ActiveSupport::Concern

  module ClassMethods
    def url_attribute(attr_name, prefix: nil)
      define_method(:"#{attr_name}=") do |value|
        return super(value) if value.blank?

        normalized_value = value.to_s.strip
        normalized_value.gsub!(%r{^https?://}, "")
        normalized_value.gsub!(%r{^(www\.)?#{prefix}}, "") if prefix.present?
        normalized_value = yield(normalized_value) if block_given?
        super(normalized_value)
      end
    end
  end
end
