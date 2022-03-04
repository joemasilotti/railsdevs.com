class RoleLevelComponent < ApplicationComponent
  attr_reader :role_level

  def initialize(role_level)
    @role_level = role_level
  end

  def render?
    selected_role_levels.any?
  end

  def role_level_types
    RoleLevel::TYPES
  end

  def humanize(attribute)
    RoleLevel.human_attribute_name(attribute)
  end

  private

  def selected_role_levels
    role_level_types.select do |role_level_type|
      role_level.public_send("#{role_level_type}?")
    end
  end
end
