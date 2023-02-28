desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task backfill_developer_badges: :environment do
    Developer.find_each do |developer|
      CreateDeveloperBadgeJob.perform_now(developer.id)
    end
  end
end
