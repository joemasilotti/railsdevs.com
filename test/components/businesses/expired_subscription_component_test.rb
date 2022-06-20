require "test_helper"

module Businesses
  class ExpiredSubscriptionComponentTest < ViewComponent::TestCase
    test "renders the content if the business has an active subscription" do
      user = users(:subscribed_business)
      render_inline ExpiredSubscriptionComponent.new(user, business: user.business) do
        "Content"
      end
      assert_text "Content"
    end

    test "renders the notice if the business does not have an active subscription" do
      user = users(:subscribed_business)
      pay_subscriptions(:full_time).update!(ends_at: Date.yesterday)

      render_inline ExpiredSubscriptionComponent.new(user, business: user.business) do
        "Content"
      end

      assert_text I18n.t("businesses.expired_subscription_component.title")
    end

    test "renders the content if the user isn't associated with the business" do
      user = users(:prospect_developer)
      business = businesses(:subscriber)

      render_inline ExpiredSubscriptionComponent.new(user, business:) do
        "Content"
      end
      assert_text "Content"
    end
  end
end
