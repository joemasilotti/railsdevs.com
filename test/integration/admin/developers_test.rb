require "test_helper"

class Admin::DevelopersTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_developers_path
    assert_redirected_to new_user_registration_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_developers_path
    assert_redirected_to root_path
  end

  test "shows and filters businesses" do
    sign_in users(:admin)

    get admin_developers_path

    assert_select "tbody tr", 2
    assert_select "td", text: developers(:one).name
    assert_select "td", text: developers(:prospect).name

    get admin_developers_path(search_query: "Prospect")
    assert_select "tbody tr", 1
    assert_select "td", text: developers(:prospect).name
  end
end
