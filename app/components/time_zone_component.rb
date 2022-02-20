class TimeZoneComponent < ApplicationComponent
  def initialize(location)
    @time_zone = location&.time_zone
    @utc_offset = location&.utc_offset
  end

  def render?
    @time_zone.present?
  end

  def time_zone
    "#{time_zone_name} (#{render(UTCOffsetComponent.new(@utc_offset)).squish})"
  end

  def time_zone_name
    ActiveSupport::TimeZone::MAPPING.key(@time_zone)
  end
end
