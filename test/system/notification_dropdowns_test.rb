require "application_system_test_case"

class NotificationDropdownsTest < ApplicationSystemTestCase
  test "should load notifications dropdown" do
    login_as(users(:with_business_conversation))

    find("a[href='#{notifications_path}']").click
    assert_selector("div[id^='notification_']")
  end
end
