require "test_helper"

module Affiliates
  class RegistrationsTest < ActionDispatch::IntegrationTest
    include NotificationsHelper

    test "requires authentication when registering" do
      get affiliates_path
      assert_response :ok

      get new_affiliate_path
      assert_redirected_to new_user_session_path

      sign_in users(:empty)
      get new_affiliate_path
      assert_response :ok
    end

    test "accepting the terms sends admins a notification" do
      sign_in users(:empty)

      assert_sends_notification Admin::Affiliates::RegistrationNotification, to: users(:admin) do
        post affiliates_path, params: {affiliates_registration: {agreement: "1"}}
      end
      assert_redirected_to affiliates_path
    end

    test "not accepting the terms doesn't send a notification" do
      sign_in users(:empty)

      refute_sends_notifications do
        post affiliates_path, params: {affiliates_registration: {agreement: "0"}}
      end
      assert_response :unprocessable_entity
    end
  end
end
