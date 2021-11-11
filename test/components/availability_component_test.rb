require "test_helper"

class AvailabilityComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "will show Currently unavailable when nil" do
    @developer.available_on = nil
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_no_selector("svg")
    assert_selector("span", text: "Currently unavailable")
  end

  test "will show Available now" do
    @developer.available_on = Date.today - 3.weeks
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_selector("svg")
    assert_selector("span", text: "Available now")
  end

  test "will show Available in with time to availability" do
    @developer.available_on = Date.today + 2.months
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_no_selector("svg")
    assert_selector("span", text: /Available\s*in\s*2 months/m)
  end
end
