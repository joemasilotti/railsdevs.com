require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "the location is geocoded" do
    stub_geocoder("Portlandia OR USA")

    location = create_location!(
      city: "Portlandia",
      state: "OR",
      country: "USA"
    )

    assert_equal location.city, "Portland"
    assert_equal location.state, "Oregon"
    assert_equal location.country, "United States"
    assert_equal location.country_code, "US"
    assert_equal location.latitude, 45.523064
    assert_equal location.longitude, -122.676483
    assert_equal location.data, {"city" => "Portland"}
  end

  test "city district is used if city isn't present" do
    stub_geocoder("Portlandia", city: nil, city_district: "Portland Proper")
    location = create_location!(city: "Portlandia")
    assert_equal location.city, "Portland Proper"
  end

  test "coordinates are validated unless we are backfilling" do
    stub_geocoder("Portlandia")
    location = create_location!(city: "Portlandia")

    location.latitude = nil
    location.longitude = nil
    assert location.valid?(:backfill)

    refute location.valid?
    assert_equal location.errors.count, 1
    assert_not_nil location.errors[:city]
  end

  def stub_geocoder(query, city: "Portland", city_district: nil, state: "Oregon", country: "United States", country_code: "US", latitude: 45.523064, longitude: -122.676483, data: {"city" => "Portland"})
    Geocoder::Lookup::Test.add_stub(
      query, [
        {
          "city" => city,
          "city_district" => city_district,
          "state" => state,
          "country" => country,
          "country_code" => country_code,
          "coordinates" => [latitude, longitude],
          "data" => data
        }
      ]
    )
  end

  def create_location!(options = {})
    Location.create!(options.merge(developer: developers(:available)))
  end
end
