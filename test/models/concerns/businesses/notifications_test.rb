require "test_helper"

class Businesses::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include BusinessesHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    business = Business.new(business_attributes)
    assert_sends_notification NewBusinessNotification, to: users(:admin) do
      assert business.save_and_notify
    end
  end

  test "invalid records don't send notifications" do
    business = Business.new
    refute_sends_notifications do
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
