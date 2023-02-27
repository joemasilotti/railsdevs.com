require "test_helper"

module Developers
  class BadgesComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders recently active badge if the developer profile is active in last 7 days" do
      @developer.updated_at = Date.current
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-green-100']")
      assert_text "Recently Active"
    end

    test "renders feature badge if the developer profile is features" do
      @developer.feature!
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-blue-100']")
      assert_text "Featured"
    end

    test "renders high response rate badge when response rate is 90%+" do
      @developer.update(response_rate: 90)
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-purple-100']")
      assert_text "High response rate"
    end

    test "does not render high response rate badge when response rate is less than 90%" do
      @developer.update(response_rate: 89)
      render_inline BadgesComponent.new(@developer)
      assert_no_text("High response rate")
    end
  end
end
