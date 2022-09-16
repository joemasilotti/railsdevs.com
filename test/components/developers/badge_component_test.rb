require "test_helper"

module Developers
  class BadgeComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders recently active badge if the developer profile is active in last 7 days" do
      @developer.updated_at = Date.current
      render_inline BadgeComponent.new("Recently Active Developer", color: "green")
      assert_selector("span[class~='bg-green-100']")
    end

    test "renders feature badge if the developer profile is features" do
      @developer.feature!
      render_inline BadgeComponent.new("Featured Developer", color: "blue")
      assert_selector("span[class~='bg-blue-100']")
    end
  end
end
