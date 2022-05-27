require "test_helper"

class LegacyBusinessSubscriptionComponentTest < ViewComponent::TestCase
  include SubscriptionsHelper

  test "renders if the user is subscribed to a legacy business subscription" do
    user = users(:subscribed_business)
    update_subscription(:legacy)

    render_inline LegacyBusinessSubscriptionComponent.new(user) do
      "Rendered!"
    end
    assert_text "Rendered!"
  end

  test "does not render otherwise" do
    user = users(:subscribed_business)
    render_inline LegacyBusinessSubscriptionComponent.new(user) do
      "Rendered!"
    end
    assert_selector "*", count: 0

    render_inline LegacyBusinessSubscriptionComponent.new(nil) do
      "Rendered!"
    end
    assert_selector "*", count: 0
  end
end
