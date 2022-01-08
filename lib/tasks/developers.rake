namespace :developers do
  desc "Set developers.utc_offset for records with a time zone."
  task utc_offset: :environment do
    Developer.where.not(time_zone: [nil, ""]).find_each do |developer|
      utc_offset = ActiveSupport::TimeZone.new(developer.time_zone).utc_offset
      developer.update_column(:utc_offset, utc_offset) unless utc_offset == developer.utc_offset
    end
  end
end
