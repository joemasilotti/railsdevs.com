require "test_helper"

module Developers
  class BadgesComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders recently added badge if the developer profile was added in the last 7 days" do
      @developer.created_at = Date.current
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-green-100']")
      assert_text "New profile"

      @developer.created_at = 2.weeks.ago
      render_inline BadgesComponent.new(@developer)
      refute_text "New profile"
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
