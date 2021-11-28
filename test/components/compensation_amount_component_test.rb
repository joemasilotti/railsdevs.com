require "test_helper"

class CompensationAmountComponentTest < ViewComponent::TestCase
  test "doesn't render without amounts" do
    render_inline CompensationAmountComponent.new(amount_range: [], suffix: nil)
    assert_no_select "*"
  end

  test "renders with amount range in USD" do
    render_inline CompensationAmountComponent.new(amount_range: [150, 250], suffix: "hr")
    assert_text "$150 - $250 /hr"
  end

  test "renders with only 1 value" do
    render_inline CompensationAmountComponent.new(amount_range: [250], suffix: "hr")
    assert_text "$250 /hr"
  end
end
