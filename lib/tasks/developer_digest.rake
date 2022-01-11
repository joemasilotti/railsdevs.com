namespace :developer_digest do
  desc "Email subscribed businesses about new developers in the last day"
  task daily: :environment do
    Business::DeveloperDigest.new(timeframe: :daily).digest
  end

  desc "Email subscribed businesses about new developers in the last week"
  task weekly: :environment do
    Business::DeveloperDigest.new(timeframe: :weekly).digest
  end
end
