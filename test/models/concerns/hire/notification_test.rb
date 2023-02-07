require "test_helper"

class Hire::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include HireFormsHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    hire_form = Hire::Form.new(form_attributes)
    assert_sends_notification Admin::NewHireFormNotification, to: users(:admin) do
      assert hire_form.save_and_notify
    end
  end

  test "invalid records don't send notifications" do
    hire_form = Hire::Form.new
    refute_sends_notifications do
      refute hire_form.save_and_notify
    end
  end
end
