class DeveloperQueryComponent < ApplicationComponent
  attr_reader :query

  delegate :sort, to: :query

  def initialize(query)
    @query = query
  end

  def selected?(time_zone_pair)
    query.time_zones.include?(time_zone_pair.first)
  end

  def time_zones
    @time_zones ||= Developer.where.not(time_zone: [nil, ""])
      .map { |d| formatted_time_zone(d.time_zone) }
      .uniq.sort
      .map { |offset| [offset, "#{offset} #{t("developer_query_component.gmt")}"] }
  end

  private

  def formatted_time_zone(time_zone)
    utc_offset = ActiveSupport::TimeZone.new(time_zone).utc_offset.fdiv(SECONDS_IN_AN_HOUR)
    number_with_precision(utc_offset, precision: 1, strip_insignificant_zeros: true)
  end
end
