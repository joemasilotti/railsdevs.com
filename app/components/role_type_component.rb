class RoleTypeComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    developer_role_types.any?
  end

  def role_types
    %i[part_time_contract full_time_contract full_time_employment]
  end

  def developer_role_types
    role_types.select do |role|
      developer.public_send("#{role}?")
    end
  end

  def humanize(attribute)
    Developer.human_attribute_name(attribute)
  end
end
