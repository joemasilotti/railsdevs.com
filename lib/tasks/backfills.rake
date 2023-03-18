desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task specialties: :environment do
    specialties = YAML.load_file(Rails.root.join("db", "seeds", "specialties.yml"))
    specialties.each do |specialty|
      Specialty.find_or_create_by!(name: specialty)
    end
  end
end
