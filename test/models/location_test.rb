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

  test "the time zone and UTC offset are populated" do
    travel_to Time.zone.local(2022, 6, 26) do
      stub_geocoder("Portlandia")

      location = create_location!(city: "Portlandia")

      assert_equal location.time_zone, "America/Los_Angeles"
      assert_equal location.utc_offset, PACIFIC_UTC_OFFSET
    end
  end

  test "city district is used if city isn't present" do
    stub_geocoder("Portlandia", city: nil, city_district: "Portland Proper")
    location = create_location!(city: "Portlandia")
    assert_equal location.city, "Portland Proper"
  end

  test "coordinates are validated" do
    stub_geocoder("Portlandia")
    location = create_location!(city: "Portlandia")

    location.latitude = nil
    location.longitude = nil

    refute location.valid?
  end

  test "unknown geocoding results invalidates the object" do
    location = create_location!(time_zone: "UTC", utc_offset: 0, latitude: 1, longitude: 2)

    Geocoder::Lookup::Test.add_stub("Unknown City", [])
    location.city = "Unknown City"

    refute location.valid?
  end

  test "creating a new record with latitude and longitude already present does not geocode" do
    raise_on_geocoding do
      create_location!(city: "Foo City", latitude: 1, longitude: 2, time_zone: "EST", utc_offset: 0)
    end
  end

  test "top_countries does not include least common countries (or nil)" do
    stub_geocoder("Shanghai", country: "China")
    (0..5).each { |_n| create_location!(city: "Shanghai") }
    stub_geocoder("Mumbai", country: "India")
    create_location!(city: "Atlantis").update!(country: nil)

    top_countries = Location.top_countries(3)

    assert_equal 2, top_countries.count
    assert top_countries.include?("China")
    refute top_countries.include?("India")
  end

  test "not_top_countries does include least common countries" do
    stub_geocoder("Shanghai", country: "China")
    5.times { create_location!(city: "Shanghai") }

    stub_geocoder("Mumbai", country: "India")
    2.times { create_location!(city: "Mumbai") }

    not_top_countries = Location.not_top_countries(2)

    assert_equal 1, not_top_countries.count
    refute_includes not_top_countries, "China"
    assert_includes not_top_countries, "United States"
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
    Location.create!(options.merge(developer: developers(:one)))
  end

  def raise_on_geocoding(&block)
    raises_exception = ->(query) { raise StandardError.new }
    Geocoder.stub(:search, raises_exception, &block)
  end
end
