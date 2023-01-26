require "test_helper"

class SuspendedAccountsTest < ActionDispatch::IntegrationTest
  test "non-suspended accounts can visit the site" do
    get developers_path
    assert_response :ok

    sign_in users(:business)
    get developers_path
    assert_response :ok
  end

  test "suspended accounts are redirected" do
    sign_in users(:suspended)
    get developers_path
    assert_redirected_to users_suspended_path
    follow_redirect!
  end

  test "suspended accounts can view the hiring agreement" do
    sign_in users(:suspended)
    get hiring_agreement_terms_path
    assert_response :ok
  end
end
