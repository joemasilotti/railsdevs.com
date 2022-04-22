require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  test "signing in with a developer profile redirects back" do
    sign_in users(:developer)
    get root_path
    get new_user_session_path
    assert_redirected_to root_path
  end

  test "signing in with a business profile redirects back" do
    sign_in users(:business)
    get root_path
    get new_user_session_path
    assert_redirected_to root_path
  end

  test "signing in without either redirects to selecting a role" do
    sign_in users(:empty)
    get new_user_session_path
    assert_redirected_to new_role_path
  end
end
