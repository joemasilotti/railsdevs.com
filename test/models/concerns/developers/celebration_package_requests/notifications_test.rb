require "test_helper"

module Developers
  module CelebrationPackageRequests
    class NotificationsTest < ActiveSupport::TestCase
      include ActionMailer::TestHelper
      include Developers::CelebrationPackageRequestsHelper
      include NotificationsHelper

      test "sends a notification to the admins" do
        celebration_package_request = Developers::CelebrationPackageRequest.new(form_attributes)
        assert_sends_notification Admin::Developers::NewCelebrationPackageRequestNotification, to: users(:admin) do
          assert celebration_package_request.save_and_notify
        end
      end

      test "invalid records don't send notifications" do
        celebration_package_request = Developers::CelebrationPackageRequest.new
        refute_sends_notifications do
          refute celebration_package_request.save_and_notify
        end
      end
    end
  end
end
