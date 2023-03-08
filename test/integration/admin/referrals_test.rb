require "test_helper"

class ReferralsTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_referrals_path
    assert_redirected_to new_user_session_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_referrals_path
    assert_redirected_to root_path
  end

  test "list all users referrals" do
    sign_in users(:admin)
    get admin_referrals_path
    assert_select "tr td", text: users(:developer).email
  end
end
