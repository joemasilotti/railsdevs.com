require "test_helper"

class CompensationAmountComponentTest < ViewComponent::TestCase
  test "doesn't render with no amount" do
    render_inline CompensationAmountComponent.new(amount: nil, title: "Hourly")
    assert_no_select "*"
  end

  test "renders with amount in USD and title" do
    render_inline CompensationAmountComponent.new(amount: 150, title: "Hourly")
    assert_text "Hourly"
    assert_text "$150.00"
  end
end
