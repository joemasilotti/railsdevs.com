require "test_helper"

class API::V1::NotificationTokensTest < ActionDispatch::IntegrationTest
  test "requires valid authentication token" do
    post api_v1_notification_tokens_path, params: valid_params, headers: {}
    assert_response :unauthorized
  end

  test "persists the notification token" do
    assert_changes "NotificationToken.count", 1 do
      post api_v1_notification_tokens_path, params: valid_params, headers: valid_headers
      assert_response :created
    end

    token = NotificationToken.last
    assert_equal users(:empty), token.user
    assert_equal "some-token", token.token
    assert_equal "iOS", token.platform
  end

  test "doesn't create duplicates" do
    assert_no_changes "NotificationToken.count" do
      post api_v1_notification_tokens_path, params: existing_token_params, headers: valid_headers
      assert_response :created
    end
  end

  def valid_params
    {
      token: "some-token",
      platform: "iOS"
    }
  end

  def valid_headers
    {
      Authorization: "Bearer #{users(:empty).authentication_token}"
    }
  end

  def existing_token_params
    {
      platform: notification_tokens(:ios).platform,
      token: notification_tokens(:ios).token
    }
  end
end
