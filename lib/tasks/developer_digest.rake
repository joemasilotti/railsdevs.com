namespace :developer_digest do
  desc "email subscribed businesses about new developers in the last day"
  task daily: :environment do
    businesses = Business.daily_developer_notifications
    developers = Developer.where("created_at > '#{1.day.ago}'")

    if developers.empty?
      puts "There are no new developers to mention at this time."
    else
      total_emails = businesses.length
      puts "Sending daily digests to #{total_emails} businesses:"

      businesses.each_with_index do |business, i|
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%"
        BusinessMailer.with(business: business, developers: developers).new_developer_profile.deliver_now
      end
    end
  end

  desc "email subscribed businesses about new developer s in the last week"
  task weekly: :environment do
    businesses = Business.weekly_developer_notifications
    developers = Developer.where("created_at > '#{1.week.ago}'")

    if developers.empty?
      puts "There are no new developers to mention at this time."
    else
      total_emails = businesses.length
      puts "Sending weekly digests to #{total_emails} businesses:"

      businesses.each_with_index do |business, i|
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%"
        BusinessMailer.with(business: business, developers: developers).new_developer_profile.deliver_now
      end
    end
  end
end
