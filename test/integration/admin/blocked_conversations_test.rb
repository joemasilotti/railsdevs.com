require "test_helper"

class Admin::BlockedConversationsTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_conversations_path
    assert_redirected_to new_user_registration_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_conversations_path
    assert_redirected_to root_path
  end

  test "shows only blocked conversations" do
    sign_in users(:admin)

    get admin_conversations_path

    assert_select "p", text: developers(:with_blocked_conversation).hero
    assert_select "p", text: developers(:with_conversation).hero, count: 0
  end
end
