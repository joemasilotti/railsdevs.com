require "test_helper"

class SubscriptionCTAComponentTest < ViewComponent::TestCase
  test "should hide results on page 2+ with a CTA for non-subscribers (rounding profile count)" do
    user = users(:business)
    developers = 110

    render_inline(SubscriptionCTAComponent.new(user:, developers:))
    assert_text I18n.t("subscription_cta_component.title")
    assert_text I18n.t("subscription_cta_component.description", developers: 100)
  end

  test "should display results on page 2+ for subscribers (rounding profile count)" do
    user = users(:subscribed_business)
    developers = 110

    render_inline(SubscriptionCTAComponent.new(user:, developers:))
    assert_no_text I18n.t("subscription_cta_component.title")
    assert_no_text I18n.t("subscription_cta_component.description", developers: 100)
  end
end
