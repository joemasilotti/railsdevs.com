require "test_helper"

module Locations
  class TimeZoneComponentTest < ViewComponent::TestCase
    test "it does not render if time zone is not present" do
      render_inline TimeZoneComponent.new(Location.new)
      refute_component_rendered

      render_inline TimeZoneComponent.new(nil)
      refute_component_rendered
    end

    test "it renders the human readable time zone" do
      render(time_zone: "America/Los_Angeles", utc_offset: PACIFIC_UTC_OFFSET)
      assert_selector("span", text: "Pacific Time (US & Canada) (GMT-8)")

      render(time_zone: "Europe/Paris", utc_offset: 3600)
      assert_selector("span", text: "Paris (GMT+1)")

      render(time_zone: "Asia/Kolkata", utc_offset: 19800)
      assert_selector("span", text: "Chennai (GMT+5.5)")
    end

    def render(time_zone:, utc_offset:)
      location = Location.new(time_zone:, utc_offset:)
      render_inline TimeZoneComponent.new(location)
    end
  end
end
