require "test_helper"

class TimeZoneComponentTest < ViewComponent::TestCase
  test "it does not render if time zone is not present" do
    render_inline TimeZoneComponent.new(nil)
    assert_no_select "*"
  end

  test "it renders if time zone is present" do
    developer = Developer.new(id: 123, time_zone: "Eastern Time (US & Canada)")
    render_inline TimeZoneComponent.new(developer.time_zone)

    assert_selector "svg[title='Clock']"
    assert_selector("span", text: "Eastern Time (US & Canada)")
  end
end
