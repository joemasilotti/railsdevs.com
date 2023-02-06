desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task developer_response_rate: :environment do
    begin
      ActiveRecord::Migration.check_pending!
    rescue ActiveRecord::PendingMigrationError => e
      if e.message.include?("add_response_rate_to_developers")
        puts e.message
        exit 1
      end
    end
    Developer.find_each(batch_size: 50) do |developer|
      UpdateDeveloperResponseRateJob.perform_now(developer)
      sleep(0.01)
    end
  end
end
