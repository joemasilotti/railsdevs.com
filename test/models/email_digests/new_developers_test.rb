require "test_helper"

class EmailDigests::NewDevelopersTest < ActionMailer::TestCase
  include DevelopersHelper

  test "daily emails for developers who signed up yesterday" do
    create_developers

    args = {business: businesses(:two), developers: [@yesterday]}
    assert_enqueued_email_with BusinessMailer, :developer_profiles, args: do
      EmailDigests::NewDevelopers.new.send_daily_digest
    end
  end

  test "do not send daily emails if no new developers signed up yesterday" do
    create_developer(2.days.ago)

    assert_no_emails do
      EmailDigests::NewDevelopers.new.send_daily_digest
    end
  end

  test "weekly emails for developers who signed up last week" do
    travel_to monday do
      create_developers

      developers = [@yesterday, @two_days_ago, @seven_days_ago]
      args = {business: businesses(:with_conversation), developers:}
      assert_enqueued_email_with BusinessMailer, :developer_profiles, args: do
        EmailDigests::NewDevelopers.new.send_weekly_digest
      end
    end
  end

  test "weekly emails are only sent on Mondays" do
    travel_to monday + 1.day do
      create_developers

      assert_no_emails do
        EmailDigests::NewDevelopers.new.send_weekly_digest
      end
    end
  end

  test "do not send weekly emails if no new developers signed up this week" do
    travel_to monday do
      create_developer(8.days.ago)

      assert_no_emails do
        EmailDigests::NewDevelopers.new.send_weekly_digest
      end
    end
  end

  test "businesses without an active subscription don't receive emails, even if subscribed" do
    create_developers
    businesses(:two).user.payment_processor.destroy

    assert_no_emails do
      EmailDigests::NewDevelopers.new.send_daily_digest
    end
  end

  def create_developers
    create_developer(Time.current)
    @yesterday = create_developer(1.day.ago)
    @two_days_ago = create_developer(2.days.ago)
    @seven_days_ago = create_developer(7.days.ago)
    create_developer(8.days.ago)
  end

  def create_developer(created_at)
    Developer.create!(developer_attributes.merge(created_at:))
  end

  def monday
    Time.zone.local(2022, 1, 3).noon
  end
end
