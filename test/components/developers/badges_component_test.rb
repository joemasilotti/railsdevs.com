require "test_helper"

module Developers
  class BadgesComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders feature badge if the developer profile is featured" do
      @developer.featured_at = Time.now
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-blue-100']")
      assert_text "Featured"

      @developer.featured_at = 2.weeks.ago
      render_inline BadgesComponent.new(@developer)
      assert_no_text "Featured"
    end

    test "renders high response rate badge when response rate is 90%+" do
      @developer.response_rate = 90
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-purple-100']")
      assert_text "High response rate"

      @developer.response_rate = 89
      render_inline BadgesComponent.new(@developer)
      assert_no_text("High response rate")
    end

    test "renders source contributor badge" do
      @developer.source_contributor = true
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-gray-100']")
      assert_text "Source contributor"

      @developer.source_contributor = false
      render_inline BadgesComponent.new(@developer)
      assert_no_text "Source contributor"
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

    test "renders recently updated badge if the developer's profile was updated in the last 7 days" do
      @developer.created_at = Date.current
      render_inline BadgesComponent.new(@developer)
      assert_selector("span[class~='bg-green-100']")
      assert_text "New profile"

      @developer.created_at = 2.weeks.ago
      render_inline BadgesComponent.new(@developer)
      refute_text "New profile"
    end
  end
end
