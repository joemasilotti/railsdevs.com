require "test_helper"

module Developers
  class PrimaryActionComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders Hire me button by default" do
      render_inline PrimaryActionComponent.new(user: nil, developer: @developer, business: nil)
      assert_text "Hire me"
      refute_text "Edit"

      user = users(:business)
      render_inline PrimaryActionComponent.new(user:, developer: @developer, business: nil)
      assert_text "Hire me"
    end

    test "renders Edit button to owner of profile" do
      user = users(:developer)
      render_inline PrimaryActionComponent.new(user:, developer: @developer, business: nil)
      assert_text "Edit"
    end

    test "renders Message button if conversation already started" do
      user = users(:subscribed_business)
      business = user.business
      render_inline PrimaryActionComponent.new(user:, developer: @developer, business:)
      assert_text "Hire me"

      conversation = conversations(:one)
      business = conversation.business
      developer = conversation.developer
      user = business.user
      render_inline PrimaryActionComponent.new(user:, developer:, business:)
      assert_text "Message"
    end
  end
end
