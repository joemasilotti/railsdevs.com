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

  test "creating an account persists the referral code" do
    get root_path(ref: "ref-code")
    user = register_new_user
    assert_equal "ref-code", user.referral.code
  end

  test "invalid account creation doesn't persist referral code" do
    get root_path(ref: "ref-code")

    assert_no_changes "User.count" do
      post user_registration_path(user: {
        email: users(:empty).email
      })
    end

    assert_nil users(:empty).referral
  end

  test "doesn't persist a referral if not referred" do
    user = register_new_user
    assert_nil user.referral
  end

  def register_new_user
    assert_changes "User.count", 1 do
      post user_registration_path(user: {
        email: "referred@example.com",
        password: "password",
        password_confirmation: "password"
      })
    end

    user = User.find_by(email: "referred@example.com")
    user.confirm
    user
  end
end
