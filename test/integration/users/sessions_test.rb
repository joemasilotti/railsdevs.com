require "test_helper"

class Users::SessionsTest < ActionDispatch::IntegrationTest
  test "it redirects to developer profile if profile is present" do
    post user_session_path user: {email: users(:with_profile_one).email, password: "password"}
    assert_redirected_to developer_path developers(:one)
  end

  test "it redirects to root path when user does not have developer account" do
    post user_session_path user: {email: users(:without_profile).email, password: "password"}
    assert_redirected_to root_path
  end

  test "it redirects to root path after log out" do
    sign_in users(:with_profile_one)
    delete destroy_user_session_path

    assert_redirected_to root_path
  end

  test "it redirects to referrer when logging out if referer is set" do
    sign_in users(:with_profile_one)
    delete destroy_user_session_path, headers: {HTTP_REFERER: developer_path(developers(:one))}

    assert_redirected_to developer_path developers(:one)
  end
end
