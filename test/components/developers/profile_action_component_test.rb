require "test_helper"

module Developers
  class ProfileActionComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "should show add my profile for non-developers" do
      render_inline ProfileActionComponent.new(nil)

      assert_text "Add my profile"
      refute_text "Update my profile"

      user = users(:business)
      render_inline ProfileActionComponent.new(user)

      assert_text "Add my profile"
    end

    test "should show update my profile for developers" do
      user = users(:developer)
      render_inline ProfileActionComponent.new(user)

      assert_text "Update my profile"
    end
  end
end
