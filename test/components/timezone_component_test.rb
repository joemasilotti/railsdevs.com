require "test_helper"

class TimeZoneComponentTest < ViewComponent::TestCase
  test "it does not render if time zone is not present" do
    render_inline TimeZoneComponent.new(Location.new)
    assert_no_select "*"

    render_inline TimeZoneComponent.new(nil)
    assert_no_select "*"
  end

  test "it renders the human readable time zone" do
    location = Location.new(time_zone: "America/Los_Angeles")
    render_inline TimeZoneComponent.new(location)

    assert_selector "svg[title='Clock']"
    assert_selector("span", text: "Pacific Time (US & Canada)")
  end
end
