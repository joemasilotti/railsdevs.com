class DeveloperQueryComponent < ApplicationComponent
  attr_reader :query

  delegate :sort, to: :query

  def initialize(query)
    @query = query
  end

  def time_zone_selected?(time_zone_pair)
    query.utc_offsets.include?(time_zone_pair.first.to_f)
  end

  def time_zones
    @time_zones ||= utc_offsets.map do |utc_offset|
      [utc_offset, render(UTCOffsetComponent.new(utc_offset))]
    end
  end

  def role_selected?(role_pair)
    query.role_types.include?(role_pair.first)
  end

  def role_types
    RoleType::TYPES.map { |role| [role, RoleType.human_attribute_name(role)] }
  end

  def include_not_interested?
    query.include_not_interested
  end

  private

  def utc_offsets
    Location.order(:utc_offset).distinct.pluck(:utc_offset)
  end
end
