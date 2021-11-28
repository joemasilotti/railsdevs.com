require "test_helper"

class PreferredCompensationComponentTest < ViewComponent::TestCase
  setup do
    @developer = developers(:available)
  end

  test "doesn't render without an expected compensation" do
    render_inline(PreferredCompensationComponent.new(@developer))
    assert_no_select "*"
  end

  test "renders hourly rate if provided" do
    @developer.preferred_min_hourly_rate = 150
    render_inline(PreferredCompensationComponent.new(@developer))
    assert_text "$150"
  end

  test "renders yearly salary if provided" do
    @developer.preferred_min_salary = 250000
    render_inline(PreferredCompensationComponent.new(@developer))
    assert_text "$250K"
  end
end
