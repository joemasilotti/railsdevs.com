require "test_helper"

class CompensationAmountComponentTest < ViewComponent::TestCase
  test "doesn't render with no amount" do
    render_inline CompensationAmountComponent.new(min_amount: nil, max_amount: nil, suffix: nil, title: "Hourly")
    assert_no_select "*"
  end

  test "renders with amount in USD and title" do
    render_inline CompensationAmountComponent.new(min_amount: 150, max_amount: 250, suffix: "hr", title: "Hourly")
    assert_text "Hourly"
    assert_text "150 -\n    $250 /hr"
  end
end
