class LocationComponent < ApplicationComponent
  def initialize(location)
    @location = location
  end

  def render?
    location.present?
  end

  def icon
    "icons/outline/globe.svg"
  end

  def location
    country = @location.country_code.downcase == "us" ? nil : @location.country
    [@location.city, @location.state, country].select(&:present?).join(", ")
  end
end
