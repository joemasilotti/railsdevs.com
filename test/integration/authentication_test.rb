require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "redirects to the stored location" do
    get new_developer_path
    assert_redirected_to new_user_session_path

    login(users(:empty))
    assert_redirected_to new_developer_path
  end

  test "redirects to the root path with a developer profile" do
    login(users(:developer))
    assert_redirected_to root_path
  end

  test "redirects to the root path with a business profile" do
    login(users(:business))
    assert_redirected_to root_path
  end

  test "redirects to the new role path otherwise" do
    login(users(:empty))
    assert_redirected_to new_role_path
  end

  def login(user)
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
    assert_equal I18n.t("devise.sessions.signed_in"), flash[:notice]
  end
end
