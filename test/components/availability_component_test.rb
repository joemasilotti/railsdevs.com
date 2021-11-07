require "test_helper"

class AvailabilityComponentTest < ViewComponent::TestCase
  test "will show Currently unavailable when nil" do
    render_inline(AvailabilityComponent.new(available_on: nil))

    assert_no_selector("svg")
    assert_selector("span", text: "Currently unavailable")
  end

  test "will show Available now" do
    render_inline(AvailabilityComponent.new(available_on: Date.current - 3.days))

    assert_selector("svg")
    assert_selector("span", text: "Available now")
  end

  test "will show Available in with time to availability" do
    render_inline(AvailabilityComponent.new(available_on: Date.current + 3.days))

    assert_no_selector("svg")
    assert_selector("span", text: /Available\s*in\s*3 days/m)
  end
end
