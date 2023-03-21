require "test_helper"

module Forms
  module Businesses
    class Hires::Notifications::NotificationsTest < ActiveSupport::TestCase
      include ActionMailer::TestHelper
      include Forms::Businesses::HiresHelper
      include NotificationsHelper

      test "sends a notification to the admins" do
        hire_form = Forms::Businesses::Hire.new(form_attributes)
        assert_sends_notification Admin::Forms::Businesses::HireNotification, to: users(:admin) do
          assert hire_form.save_and_notify
        end
      end

      test "invalid records don't send notifications" do
        hire_form = Forms::Businesses::Hire.new
        refute_sends_notifications do
          refute hire_form.save_and_notify
        end
      end
    end
  end
end
