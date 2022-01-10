namespace :developer_digest do
  desc "Email subscribed businesses about new developers in the last day"
  task daily: :environment do
    DeveloperDigest.new(:daily).call
  end

  desc "Email subscribed businesses about new developers in the last week"
  task weekly: :environment do
    DeveloperDigest.new(:weekly).call
  end
end
