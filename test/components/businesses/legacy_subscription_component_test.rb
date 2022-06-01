require "test_helper"

module Businesses
  class LegacySubscriptionComponentTest < ViewComponent::TestCase
    include SubscriptionsHelper

    test "renders if the user is subscribed to a legacy business subscription" do
      user = users(:subscribed_business)
      update_subscription(:legacy)

      render_inline LegacySubscriptionComponent.new(user) do
        "Rendered!"
      end
      assert_text "Rendered!"
    end

    test "does not render otherwise" do
      user = users(:subscribed_business)
      render_inline LegacySubscriptionComponent.new(user) do
        "Rendered!"
      end
      assert_selector "*", count: 0

      render_inline LegacySubscriptionComponent.new(nil) do
        "Rendered!"
      end
      assert_selector "*", count: 0
    end
  end
end
