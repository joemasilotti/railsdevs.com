namespace :developer_digest do
  desc "Email subscribed businesses about new developers in the last day"
  task daily: :environment do
    EmailDigests::NewDevelopers.new.send_daily_digest
  end

  desc "Email subscribed businesses about new developers in the last week"
  task weekly: :environment do
    EmailDigests::NewDevelopers.new.send_weekly_digest
  end
end
