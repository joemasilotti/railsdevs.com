require "test_helper"

module Developers
  class UnseededWarningComponentTest < ViewComponent::TestCase
    test "hidden when unseedable" do
      render_inline UnseededWarningComponent.new(seedable: false)
      assert_no_text "Run bin/rails db:seed"
    end

    test "hidden when seedable but developers exist" do
      render_inline UnseededWarningComponent.new(seedable: true)
      assert_no_text "Run bin/rails db:seed"
    end

    test "displayed when seedable and no developers exist" do
      Developer.destroy_all
      render_inline UnseededWarningComponent.new(seedable: true)
      assert_text "Run bin/rails db:seed"
    end
  end
end
