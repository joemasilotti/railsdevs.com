module GeocoderHelper
  extend ActiveSupport::Concern

  Geocoder.configure(lookup: :test, ip_lookup: :test)

  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        "city" => "New York",
        "state" => "New York",
        "country" => "United States",
        "country_code" => "US",
        "coordinates" => [40.7143528, -74.0059731],
        "data" => {}
      }
    ]
  )
end
