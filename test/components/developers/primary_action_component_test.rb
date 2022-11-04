require "test_helper"

module Developers
  class PrimaryActionComponentTest < ViewComponent::TestCase
    setup do
      @developer = developers(:one)
    end

    test "renders Hire me button by default" do
      render_component
      assert_text "Hire me"
      refute_text "Edit"

      render_component(user: users(:business))
      assert_text "Hire me"
    end

    test "renders Edit button to owner of profile" do
      render_component(user: users(:developer))
      assert_text "Edit"
    end

    test "renders Message button if conversation already started" do
      user = users(:subscribed_business)
      render_component(business: user.business)
      assert_text "Hire me"

      conversation = conversations(:one)
      business = conversation.business
      render_component(user: business.user, developer: conversation.developer, business: user.business)
      assert_text "Message"
    end

    test "renders Share button to owner of profile" do
      render_component
      refute_text "Share"

      render_component(user: users(:developer))
      assert_text "Share"
    end

    test "renders a mailto: link when accessing a valid public profile" do
      render_component
      assert_selector "a[href='mailto:#{@developer.user.email}']", count: 0

      render_component(public_key: "invalid-key")
      assert_selector "a[href='mailto:#{@developer.user.email}']", count: 0

      render_component(public_key: @developer.public_profile_key)
      assert_selector "a[href='mailto:#{@developer.user.email}']"
    end

    def render_component(user: nil, developer: @developer, business: nil, public_key: nil)
      render_inline PrimaryActionComponent.new(user:, developer:, business:, public_key:)
    end
  end
end
