require "test_helper"

class Businesses::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include BusinessesHelper

  test "sends a notification to the admins" do
    business = Business.new(business_attributes)
    assert_difference "Notification.count", 1 do
      assert business.save_and_notify
    end

    assert_equal Notification.last.type, NewBusinessNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "invalid records don't send notifications" do
    business = Business.new
    assert_no_difference "Notification.count" do
      refute business.save_and_notify
    end
  end

  test "sends the welcome email" do
    business = Business.new(business_attributes)
    assert business.save_and_notify
    assert_enqueued_email_with BusinessMailer, :welcome_email, args: {business:}
  end

  test "invalid records don't send welcome emails" do
    business = Business.new
    refute business.save_and_notify
    assert_no_enqueued_emails
  end
end
