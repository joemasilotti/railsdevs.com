class RoleTypeComponent < ApplicationComponent
  attr_reader :role_type

  def initialize(role_type)
    @role_type = role_type
  end

  def render?
    selected_role_types.any?
  end

  def role_types
    %i[part_time_contract full_time_contract full_time_employment]
  end

  def selected_role_types
    role_types.select do |rt|
      role_type.public_send("#{rt}?")
    end
  end

  def humanize(attribute)
    RoleType.human_attribute_name(attribute)
  end
end
