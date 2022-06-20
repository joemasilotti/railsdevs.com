class Location < ApplicationRecord
  belongs_to :developer

  scope :top_countries, ->(limit = ENV.fetch("TOP_COUNTRIES", 5)) do
    group(:country)
      .where.not(country: nil)
      .order("count_all DESC")
      .limit(limit)
      .count
      .keys
  end

  scope :not_top_countries, ->(limit = ENV.fetch("TOP_COUNTRIES", 5)) do
    where.not(country: top_countries(limit))
      .select(:country)
      .distinct
      .order(:country)
      .pluck(:country)
  end

  validates :time_zone, presence: true
  validates :utc_offset, presence: true
  validate :valid_coordinates

  before_validation :geocode,
    if: ->(location) do
      location.will_save_change_to_city? ||
        location.will_save_change_to_state? ||
        location.will_save_change_to_country?
    end,
    unless: ->(location) do
      location.new_record? && latitude.present? && longitude.present?
    end

  def missing_fields?
    country.blank?
  end

  private

  def valid_coordinates
    if latitude.blank? || longitude.blank?
      # i18n-tasks-use t('activerecord.errors.models.location.invalid_coordinates')
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
