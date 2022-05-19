require "test_helper"

class Admin::BusinessesTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_businesses_path
    assert_redirected_to new_user_registration_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_businesses_path
    assert_redirected_to root_path
  end

  test "shows and filters businesses" do
    sign_in users(:admin)

    get admin_businesses_path
    assert_select "tbody tr", 2
    assert_select "td", text: businesses(:one).company
    assert_select "td", text: businesses(:subscriber).company

    get admin_businesses_path(search_query: "Conversation")
    assert_select "tbody tr", 1
    assert_select "td", text: businesses(:subscriber).company
  end
end
