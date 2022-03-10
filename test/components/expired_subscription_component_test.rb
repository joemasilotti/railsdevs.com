require "test_helper"

class ExpiredSubscriptionComponentTest < ViewComponent::TestCase
  test "renders the content if the business has an active subscription" do
    user = users(:with_business_conversation)
    render_inline ExpiredSubscriptionComponent.new(user, business: user.business) do
      "Content"
    end
    assert_text "Content"
  end

  test "renders the notice if the business does not have an active subscription" do
    user = users(:with_business_conversation)
    pay_subscriptions(:two).update!(ends_at: Date.yesterday)

    render_inline ExpiredSubscriptionComponent.new(user, business: user.business) do
      "Content"
    end

    assert_text I18n.t("expired_subscription_component.title")
  end

  test "renders the content if the user isn't associated with the business" do
    user = users(:with_developer_conversation)
    business = businesses(:with_conversation)

    render_inline ExpiredSubscriptionComponent.new(user, business:) do
      "Content"
    end
    assert_text "Content"
  end
end
