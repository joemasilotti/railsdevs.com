class LocationComponent < ApplicationComponent
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def render?
    location.present?
  end

  def icon
    "icons/outline/globe.svg"
  end
end
