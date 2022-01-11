require "test_helper"

class DeveloperDigestTest < ActionMailer::TestCase
  test "should send daily email digests to appropriate businesses" do
    developers = Developer.where(created_at: 1.day.ago..Time.now )
    businesses = Business.daily_developer_notifications
    mailer = Business::DeveloperDigest.new(timeframe: :daily)

    assert_emails(businesses.length) do
      mailer.digest
    end
    assert_equal developers.length, mailer.developers.length
  end

  test "should send weekly email digests to appropriate businesses" do
    developers = Developer.where(created_at: 1.week.ago..Time.now)
    businesses = Business.weekly_developer_notifications
    mailer = Business::DeveloperDigest.new(timeframe: :weekly)

    assert_emails(businesses.length) do
      mailer.digest
    end
    assert_equal developers.length, mailer.developers.length
  end
end
