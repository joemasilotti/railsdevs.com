require "test_helper"

class LegacyBusinessSubscriptionComponentTest < ViewComponent::TestCase
  test "renders if the user is subscribed to a legacy business subscription" do
    user = User.new(subscribed: true)
    render_inline LegacyBusinessSubscriptionComponent.new(user) do
      "Rendered!"
    end
    assert_text "Rendered!"
  end

  test "does not render otherwise" do
    user = User.new(subscribed: false)
    render_inline LegacyBusinessSubscriptionComponent.new(user) do
      "Rendered!"
    end
    assert_selector "*", count: 0

    render_inline LegacyBusinessSubscriptionComponent.new(nil) do
      "Rendered!"
    end
    assert_selector "*", count: 0
  end

  class User
    def initialize(subscribed:)
      @subscribed = subscribed
    end

    def active_legacy_business_subscription?
      @subscribed
    end
  end
end
