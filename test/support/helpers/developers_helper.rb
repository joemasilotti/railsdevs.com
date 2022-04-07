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

      if (utc_offset = options.delete(:utc_offset))
        options[:location_attributes] = location_attributes(utc_offset)
      end

      Developer.create!(developer_attributes.merge(options))
    end

    private

    def location_attributes(utc_offset)
      {
        latitude: 1,
        longitude: 2,
        country: "United States",
        time_zone: "Fake Time Zone",
        utc_offset:
      }
    end
  end
end
