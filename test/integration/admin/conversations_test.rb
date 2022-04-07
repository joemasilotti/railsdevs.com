require "test_helper"

class Admin::ConversationsTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_conversations_path
    assert_redirected_to new_user_registration_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_conversations_path
    assert_redirected_to root_path
  end

  test "calculates stats" do
    sign_in users(:admin)
    get admin_conversations_path
    assert_select "p", text: "100%"
  end
end
