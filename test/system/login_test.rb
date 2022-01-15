require "application_system_test_case"

class LoginTest < ApplicationSystemTestCase
  test "users can log in" do
    login_as(users(:empty))
    find("#user-menu-button").click

    assert page.has_button?("Sign out")
  end
end
