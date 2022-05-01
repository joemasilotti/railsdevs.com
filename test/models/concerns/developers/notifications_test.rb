require "test_helper"

class Developers::NotificationsTest < ActiveSupport::TestCase
  include DevelopersHelper
  include ActionMailer::TestHelper

  test "sends a notification to the admins" do
    developer = Developer.new(developer_attributes)
    assert_difference "Notification.count", 1 do
      assert developer.save_and_notify
    end

    assert_equal Notification.last.type, NewDeveloperProfileNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "invalid records don't send notifications" do
    developer = Developer.new
    assert_no_difference "Notification.count" do
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
    assert_difference "Notification.count", 1 do
      developers(:one).invisiblize_and_notify!
    end

    assert_equal Notification.last.type, InvisiblizeDeveloperNotification.name
    assert_equal Notification.last.recipient, users(:developer)
  end
end
