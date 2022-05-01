require "test_helper"

class Developers::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include DevelopersHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    developer = Developer.new(developer_attributes)
    assert_sends_notification NewDeveloperProfileNotification, to: users(:admin) do
      assert developer.save_and_notify
    end
  end

  test "invalid records don't send notifications" do
    developer = Developer.new
    refute_sends_notifications do
      refute developer.save_and_notify
    end
  end

  test "sends a welcome email" do
    developer = Developer.new(developer_attributes)
    assert developer.save_and_notify
    assert_enqueued_email_with DeveloperMailer, :welcome_email, args: {developer:}
  end

  test "invalid records don't send welcome emails" do
    developer = Developer.new
    refute developer.save_and_notify
    assert_no_enqueued_emails
  end

  test "notifies the developer when they are invisibilized" do
    assert_sends_notification InvisiblizeDeveloperNotification, to: users(:developer) do
      developers(:one).invisiblize_and_notify!
    end
  end
end
