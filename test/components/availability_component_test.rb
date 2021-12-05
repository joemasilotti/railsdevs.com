require "test_helper"

class AvailabilityComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "will show Currently unavailable when nil" do
    @developer.available_on = nil
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_no_selector("svg")
    assert_selector("span", text: I18n.t("availability_component.unspecified_html"))
  end

  test "will show Available now" do
    @developer.available_on = Date.today - 3.weeks
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_selector("svg")
    assert_selector("span.text-green-700", text: I18n.t("availability_component.now_html"))
  end

  test "will show Available in with time to availability" do
    @developer.available_on = Date.today + 2.months
    render_inline(AvailabilityComponent.new(developer: @developer))

    assert_no_selector("svg")
    assert_selector("span", text: /Available\s*in\s*2 months/m)
  end

  test "unavailable icon and color" do
    @developer.available_on = nil
    render_inline(AvailabilityComponent.new(developer: @developer, show_unavailable_icon: true))

    assert_selector("svg")
    assert_selector("span", text: I18n.t("availability_component.unspecified_html"))
  end
end
