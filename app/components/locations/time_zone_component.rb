module Locations
  class TimeZoneComponent < ApplicationComponent
    attr_reader :utc_offset

    def initialize(location)
      @time_zone = location&.time_zone
      @utc_offset = location&.utc_offset
    end

    def render?
      @time_zone.present?
    end

    def time_zone
      ActiveSupport::TimeZone::MAPPING.key(@time_zone)
    end
  end
end
