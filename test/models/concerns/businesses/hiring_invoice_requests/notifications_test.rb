require "test_helper"

module Businesses
  module HiringInvoiceRequests
    class Notification::NotificationsTest < ActiveSupport::TestCase
      include ActionMailer::TestHelper
      include Admin::Businesses::HiringInvoiceRequestsHelper
      include NotificationsHelper

      test "sends a notification to the admins" do
        hire_form = Businesses::HiringInvoiceRequest.new(form_attributes)
        assert_sends_notification Admin::Businesses::HiringInvoiceRequestNotification, to: users(:admin) do
          assert hire_form.save_and_notify
        end
      end

      test "invalid records don't send notifications" do
        hire_form = Businesses::HiringInvoiceRequest.new
        refute_sends_notifications do
          refute hire_form.save_and_notify
        end
      end
    end
  end
end
