desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task developer_response_rate: :environment do
    Developer.find_each(batch_size: 50) do |developer|
      UpdateDeveloperResponseRateJob.perform_now(developer)
      sleep(0.01)
    end
  end
end
