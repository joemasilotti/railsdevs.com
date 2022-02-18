desc "These tasks are meant to be run once then removed"
namespace :backfills do
  desc "Backfill developers.time_zone to locations.time_zone"
  task time_zone: :environment do
    Developer.where.not(time_zone: [nil, ""]).find_each do |developer|
      time_zone = ActiveSupport::TimeZone.new(developer.time_zone)
      location = developer.location
      location.assign_attributes(time_zone: time_zone.tzinfo.name, utc_offset: time_zone.utc_offset)
      location.save!(context: :backfill)
    end
  end
end
