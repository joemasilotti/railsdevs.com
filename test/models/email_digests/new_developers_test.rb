require "test_helper"

class EmailDigests::NewDevelopersTest < ActionMailer::TestCase
  def setup
    create_developer(Time.current)
    @yesterday = create_developer(1.day.ago)
    @two_days_ago = create_developer(2.days.ago)
    @seven_days_ago = create_developer(7.days.ago)
    create_developer(8.days.ago)
  end

  test "daily emails for developers who signed up yesterday" do
    args = {business: businesses(:two), developers: [@yesterday]}
    assert_enqueued_email_with BusinessMailer, :developer_profiles, args: do
      EmailDigests::NewDevelopers.new.send_daily_digest
    end
  end

  test "weekly emails for developers who signed up last week" do
    developers = [@yesterday, @two_days_ago, @seven_days_ago]
    args = {business: businesses(:with_conversation), developers:}
    assert_enqueued_email_with BusinessMailer, :developer_profiles, args: do
      EmailDigests::NewDevelopers.new.send_weekly_digest
    end
  end

  test "businesses without an active subscription don't receive emails, even if subscribed" do
    businesses(:with_conversation).user.payment_processor.destroy
    assert_no_emails do
      EmailDigests::NewDevelopers.new.send_weekly_digest
    end
  end

  def create_developer(created_at)
    Developer.create!(developer_attributes.merge(created_at:))
  end

  def developer_attributes
    {
      user: users(:empty),
      name: "Name",
      hero: "Hero",
      bio: "Bio",
      avatar: active_storage_blobs(:one),
      time_zone: "Pacific Time (US & Canada)"
    }
  end
end
