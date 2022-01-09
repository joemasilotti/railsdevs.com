namespace :developer_digest do
  desc "Email subscribed businesses about new developers in the last day"
  task daily: :environment do
    businesses = Business.daily_developer_notifications
    developers = Developer.where(created_at: Date.yesterday..Date.current.to_date)

    if developers.empty?
      puts "There are no new developers to mention at this time."
    else
      total_emails = businesses.length
      puts "Sending daily digests to #{total_emails} businesses:"

      businesses.each_with_index do |business, i|
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%"
        BusinessMailer.with(business:, developers:).new_developer_profile.deliver_now
      end
    end
  end

  desc "Email subscribed businesses about new developers in the last week"
  task weekly: :environment do
    businesses = Business.weekly_developer_notifications
    developers = Developer.where(created_at: (Date.current.to_date - 7.days)..Date.current.to_date)

    if developers.empty?
      puts "There are no new developers to mention at this time."
    else
      total_emails = businesses.length
      puts "Sending weekly digests to #{total_emails} businesses:"

      businesses.each_with_index do |business, i|
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%"
        BusinessMailer.with(business:, developers:).new_developer_profile.deliver_now
      end
    end
  end
end
