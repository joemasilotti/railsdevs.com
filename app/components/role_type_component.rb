class RoleTypeComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    any_role_types?
  end

  def role_types
    %i[part_time_contract full_time_contract full_time_employment]
  end

  def humanize(attribute)
    Developer.human_attribute_name(attribute)
  end

  private

  def any_role_types?
    role_types.any? do |role|
      developer.send("#{role}?")
    end
  end
end
