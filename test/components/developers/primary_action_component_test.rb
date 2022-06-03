require "test_helper"

module Developers
  class PrimaryActionComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "should show nothing by default" do
      render_inline PrimaryActionComponent.new(user: nil, developer: @developer)

      assert_text "Hire me"
      refute_text "Edit"

      user = users(:business)
      render_inline PrimaryActionComponent.new(user:, developer: @developer)

      assert_text "Hire me"
    end

    test "should show edit to owner of profile" do
      user = users(:developer)
      render_inline PrimaryActionComponent.new(user:, developer: @developer)

      assert_text "Edit"
    end
  end
end
