require "test_helper"

module Developers
  class AvailabilityComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "will show Currently unavailable when nil" do
      @developer.available_on = nil
      render_inline(AvailabilityComponent.new(developer: @developer))

      assert_no_selector("svg")
      assert_selector("span", text: t(".unspecified_html"))
    end

    test "will show Available now" do
      @developer.available_on = Date.today - 3.weeks
      render_inline(AvailabilityComponent.new(developer: @developer))

      assert_selector("svg")
      assert_selector("span.text-green-700", text: t(".now_html"))
    end

    test "will show Available in with time to availability" do
      @developer.available_on = Date.today + 61.days
      render_inline(AvailabilityComponent.new(developer: @developer))

      assert_no_selector("svg")
      assert_selector("span", text: /Available\s*in\s*(about\s*)?2 months/m)
    end

    test "unavailable icon and color" do
      @developer.available_on = nil
      render_inline(AvailabilityComponent.new(developer: @developer, show_unavailable_icon: true))

      assert_selector("svg")
      assert_selector("span", text: t(".unspecified_html"))
    end

    def t(key)
      I18n.t(key, scope: "developers.availability_component")
    end
  end
end
