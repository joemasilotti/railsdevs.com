module RoleTypes
  class ColdMessageComponent < ApplicationComponent
    private attr_reader :role_type

    def initialize(role_type)
      @role_type = role_type
    end

    def render?
      !role_type.missing_fields?
    end

    def role_types
      RoleType::TYPES.map do |type|
        [localized(type), role_type.send("#{type}?")]
      end
    end

    def icon(enabled)
      enabled ? "icons/solid/check_circle.svg" : "icons/solid/x_circle.svg"
    end

    def css(enabled)
      "text-green-700" if enabled
    end

    private

    def localized(role_type)
      I18n.t("activerecord.attributes.role_type.#{role_type}")
    end
  end
end
