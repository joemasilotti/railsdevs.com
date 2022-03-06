class Location < ApplicationRecord
  belongs_to :developer

  validates :time_zone, presence: true
  validates :utc_offset, presence: true
  validate :valid_coordinates, unless: -> { validation_context == :backfill }

  before_validation :geocode, if: ->(location) do
    location.will_save_change_to_city? ||
      location.will_save_change_to_state? ||
      location.will_save_change_to_country?
  end

  def missing_fields?
    country.blank?
  end

  private

  def valid_coordinates
    if latitude.blank? || longitude.blank?
      errors.add(:city, :invalid_coordinates)
    end
  end

  def geocode
    if (result = Geocoder.search(query).first)
      self.city = result.city || result.city_district
      self.state = result.state
      self.country = result.country
      self.country_code = result.country_code
      self.latitude = result.latitude
      self.longitude = result.longitude
      self.data = result.data

      self.time_zone = TimezoneFinder.create.timezone_at(lat: latitude, lng: longitude)
      self.utc_offset = ActiveSupport::TimeZone.new(time_zone).utc_offset
    else
      self.latitude = nil # Invalidate record via #valid_coordinates.
    end
  end

  def query
    [city, state, country].join(" ").squish
  end
end
