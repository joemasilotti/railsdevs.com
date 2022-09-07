require "test_helper"

class Hired::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include HiredFormsHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    hired_form = Hired::Form.new(form_attributes)
    assert_sends_notification Admin::NewHiredFormNotification, to: users(:admin) do
      assert hired_form.save_and_notify
    end
  end

  test "invalid records don't send notifications" do
    hired_form = Hired::Form.new
    refute_sends_notifications do
      refute hired_form.save_and_notify
    end
  end
end
