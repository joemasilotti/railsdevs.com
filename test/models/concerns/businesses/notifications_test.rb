require "test_helper"

class Businesses::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include BusinessesHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    business = Business.new(business_attributes)
    assert_sends_notification Admin::NewBusinessNotification, to: users(:admin) do
      assert business.save_and_notify
    end
  end

  test "invalid records don't send notifications" do
    business = Business.new
    refute_sends_notifications do
      refute business.save_and_notify
    end
  end

  test "notifies the business when they are invisibilized" do
    assert_sends_notification Businesses::InvisiblizeNotification, to: users(:business) do
      businesses(:one).invisiblize_and_notify!
    end
  end
end
