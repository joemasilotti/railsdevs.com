namespace :locations do
  desc "Set locations.utc_offset from locations.time_zone"
  task utc_offset: :environment do
    Location.find_each do |location|
      utc_offset = ActiveSupport::TimeZone.new(location.time_zone).utc_offset
      location.update_column(:utc_offset, utc_offset) unless utc_offset == location.utc_offset
    end
  end
end
