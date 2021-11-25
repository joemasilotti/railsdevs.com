require "test_helper"

class ExpectedCompensationComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "renders nothing whith no expected compensation" do
    render_inline(ExpectedCompensationComponent.new(@developer))
    assert_no_select "*"
  end

  test "renders hourly rate if provided" do
    @developer.preferred_min_hourly_rate = 150
    render_inline(ExpectedCompensationComponent.new(@developer))
    assert_text "Hourly"
    assert_text "$150.00"
  end

  test "renders yearly salary if provided" do
    @developer.preferred_min_salary = 250000
    render_inline(ExpectedCompensationComponent.new(@developer))
    assert_text "Yearly salary"
    assert_text "$250,000.00"
  end
end
