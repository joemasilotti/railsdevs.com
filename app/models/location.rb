class Location < ApplicationRecord
  belongs_to :developer

  validates :city, presence: true
  validates :country, presence: true
  validate :valid_coordinates

  before_validation :geocode, if: ->(location) do
    location.will_save_change_to_city? ||
      location.will_save_change_to_state? ||
      location.will_save_change_to_country?
  end

  private

  def valid_coordinates
    if latitude.blank? || longitude.blank?
      errors.add(:city, :invalid_coordinates)
    end
  end

  def geocode
    if (result = Geocoder.search(query).first)
      self.city = result.city
      self.state = result.state
      self.country = result.country
      self.country_code = result.country_code
      self.latitude = result.latitude
      self.longitude = result.longitude
      self.data = result.data

      self.timezone = Timezone.lookup(latitude, longitude).name
    else
      self.latitude = nil
      self.longitude = nil
    end
  end

  def query
    [city, state, country].join(" ")
  end
end
