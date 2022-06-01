module DevelopersHelper
  extend ActiveSupport::Concern

  included do
    def developer_attributes
      {
        user: users(:empty),
        name: "Name",
        hero: "Hero",
        bio: "Bio",
        avatar: active_storage_blobs(:lovelace),
        location_attributes: {
          city: "City",
          state: "ST"
        }
      }
    end

    def create_developer(options = {})
      unless options.has_key?(:search_status)
        options[:search_status] = :open
      end

      if (location_attributes = options.delete(:location_attributes))
        options[:location_attributes] = default_location_attributes.merge(location_attributes)
      end

      Developer.create!(developer_attributes.merge(options))
    end

    private

    def default_location_attributes
      {
        latitude: 1,
        longitude: 2,
        country: "United States",
        time_zone: "Fake Time Zone",
        utc_offset: -8 * 60 * 60
      }
    end
  end
end
