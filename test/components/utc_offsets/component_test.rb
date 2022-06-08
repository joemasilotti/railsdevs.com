require "test_helper"

module UTCOffsets
  class ComponentTest < ViewComponent::TestCase
    test "converts UTC offsets to hours" do
      render_inline Component.new(3600)
      assert_text "1"
    end

    test "minus sign for UTC offsets west of GMT" do
      render_inline Component.new(-3600)
      assert_text "GMT-1"
    end

    test "plus sign for UTC offsets east of GMT" do
      render_inline Component.new(7200)
      assert_text "GMT+2"
    end

    test "no sign for GMT" do
      render_inline Component.new(0)
      assert_text "GMT", exact: true, normalize_ws: true
    end
  end
end
