class TimeZoneComponent < ApplicationComponent
  def initialize(location)
    @time_zone = location&.time_zone
    @utc_offset = location&.utc_offset
  end

  def render?
    @time_zone.present?
  end

  def icon
    "icons/solid/clock.svg"
  end

  def time_zone
    "#{time_zone_name} (#{gmt}#{plus_minus}#{utc_offset})"
  end

  def time_zone_name
    ActiveSupport::TimeZone::MAPPING.key(@time_zone)
  end

  def plus_minus
    "+" if @utc_offset > 0
  end

  def utc_offset
    utc_offset = @utc_offset.fdiv(SECONDS_IN_AN_HOUR)
    number_with_precision(utc_offset, precision: 1, strip_insignificant_zeros: true)
  end

  def gmt
    t("developer_query_component.gmt")
  end
end
