require "test_helper"

class API::V1::AuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:empty)
  end

  test "signing in with valid credentials returns the authentication token and user ID" do
    post api_v1_auth_path, params: valid_credentials
    assert_response :ok

    json = JSON.parse(response.body)
    assert_equal @user.authentication_token, json["token"]
    assert_equal @user.id, json["id"]
  end

  test "signing in with valid credentials sets the cookies" do
    post api_v1_auth_path, params: valid_credentials
    assert_equal [@user.id], session["warden.user.user.key"].first
  end

  test "signing in with invalid credentials returns an error message" do
    post api_v1_auth_path, params: {
      email: @user.email,
      password: "incorrect-password"
    }
    assert_response :unauthorized

    json = JSON.parse(response.body)
    assert_not_nil json["error"]
  end

  test "signing out removes the cookies" do
    post api_v1_auth_path, params: valid_credentials
    assert_not_nil session["warden.user.user.key"]

    delete api_v1_auth_path, headers: valid_headers
    assert_nil session["warden.user.user.key"]
  end

  test "signing out destroys the notification token" do
    assert_changes "NotificationToken.count", -1 do
      delete api_v1_auth_path,
        headers: valid_headers,
        params: {token: notification_tokens(:ios).token}
    end
  end

  def valid_credentials
    {
      email: @user.email,
      password: "password"
    }
  end

  def valid_headers
    {
      Authorization: @user.authentication_token
    }
  end
end
