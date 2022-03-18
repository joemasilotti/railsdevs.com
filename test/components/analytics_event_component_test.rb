require "test_helper"

class AnalyticsEventComponentTest < ViewComponent::TestCase
  test "does not render unless the goal and value are present in the hash" do
    render_inline AnalyticsEventComponent.new({})
    refute_component_rendered

    render_inline AnalyticsEventComponent.new(event: {"goal" => "ABC123"})
    refute_component_rendered

    render_inline AnalyticsEventComponent.new(event: {"value" => "4200"})
    refute_component_rendered
  end

  test "renders the Stimulus controller with goal and value values" do
    event = {"goal" => "ABC123", "value" => 4200}
    render_inline AnalyticsEventComponent.new(event:)
    assert_selector ""\
      "[data-controller=analytics--events]"\
      "[data-analytics--events-goal-value=ABC123]"\
      "[data-analytics--events-value-value=4200]"
  end
end
