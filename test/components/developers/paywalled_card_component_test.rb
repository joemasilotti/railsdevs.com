require "test_helper"

module Developers
  class PaywalledCardComponentTest < ViewComponent::TestCase
    setup do
      @developer = Developers::PaywalledDeveloper.generate
    end

    test "should render hero" do
      render_inline(PaywalledCardComponent.new(developer: @developer))

      assert_selector("h2", text: @developer.hero)
    end

    test "should render bio" do
      render_inline(PaywalledCardComponent.new(developer: @developer))

      assert_selector("p", text: @developer.bio)
    end

    test "should render avatar" do
      render_inline(PaywalledCardComponent.new(developer: @developer))

      assert_selector("img[src$='#{@developer.avatar_url}']")
    end

    test "should always render available now" do
      render_inline(PaywalledCardComponent.new(developer: @developer))

      assert_selector("span", text: "Available now")
    end
  end
end
