require "test_helper"

class DeveloperDigestTest < ActionMailer::TestCase
  test "should send daily email digests to appropriate businesses" do
    developers = Developer.where(created_at: Date.yesterday..Date.current.to_date )
    businesses = Business.daily_developer_notifications

    assert_emails(businesses.length) do
      Business::DeveloperDigest.new(timeframe: :daily).digest
    end
  end

  test "should send weekly email digests to appropriate businesses" do
    developers = Developer.where(created_at: (Date.current.to_date - 7.days)..Date.current.to_date)
    businesses = Business.weekly_developer_notifications

    assert_emails(businesses.length) do
      Business::DeveloperDigest.new(timeframe: :weekly).digest
    end
  end
end
