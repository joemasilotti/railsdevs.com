require "test_helper"

class UTCOffsetComponentTest < ViewComponent::TestCase
  test "converts UTC offsets to hours" do
    render_inline UTCOffsetComponent.new(3600)
    assert_text "1"
  end

  test "minus sign for UTC offsets west of GMT" do
    render_inline UTCOffsetComponent.new(-3600)
    assert_text "GMT-1"
  end

  test "plus sign for UTC offsets east of GMT" do
    render_inline UTCOffsetComponent.new(7200)
    assert_text "GMT+2"
  end

  test "no sign for GMT" do
    render_inline UTCOffsetComponent.new(0)
    assert_text "GMT", exact: true, normalize_ws: true
  end
end
