desc "These tasks are meant to be run once then removed"
namespace :backfills do
  desc "Migrate OpenStartup::Metric#data to JSON"
  task store: :environment do
    OpenStartup::Metric.find_each do |metric|
      metric.update!(data_json: metric.data)
    end
  end
end
