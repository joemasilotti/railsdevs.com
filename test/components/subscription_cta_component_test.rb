require "test_helper"

class SubscriptionCTAComponentTest < ViewComponent::TestCase
  test "should hide results on page 2+ with a CTA for non-subscribers" do
    user = users(:business)
    developers_count = 100

    render_inline(SubscriptionCTAComponent.new(user:, developers_count:))
    assert_text I18n.t("subscription_cta_component.title")
    assert_text I18n.t("subscription_cta_component.description", developers_count:)
  end

  test "should display results on page 2+ for subscribers" do
    user = users(:subscribed_business)
    developers_count = 100

    render_inline(SubscriptionCTAComponent.new(user:, developers_count:))
    assert_no_text I18n.t("subscription_cta_component.title")
    assert_no_text I18n.t("subscription_cta_component.description", developers_count:)
  end
end
