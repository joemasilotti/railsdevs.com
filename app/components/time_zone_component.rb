class TimeZoneComponent < ApplicationComponent
  attr_reader :time_zone

  def initialize(time_zone)
    @time_zone = time_zone
  end

  def render?
    time_zone.present?
  end

  def icon
    "icons/outline/clock.svg"
  end
end
