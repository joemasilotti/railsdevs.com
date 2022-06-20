module RoleTypes
  class Component < ApplicationComponent
    attr_reader :role_type

    def initialize(role_type)
      @role_type = role_type
    end

    def render?
      selected_role_types.any?
    end

    def role_types
      RoleType::TYPES
    end

    def humanize(attribute)
      RoleType.human_attribute_name(attribute)
    end

    private

    def selected_role_types
      role_types.select do |rt|
        role_type.public_send("#{rt}?")
      end
    end
  end
end
