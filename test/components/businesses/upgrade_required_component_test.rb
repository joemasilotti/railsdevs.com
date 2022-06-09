require "test_helper"

module Businesses
  class UpgradeRequiredComponentTest < ViewComponent::TestCase
    include SubscriptionsHelper

    test "doesn't render for admins" do
      user = users(:admin)
      render_inline UpgradeRequiredComponent.new(user)
      assert_no_selector "*"
    end

    test "expired subscriptions see reactivation copy" do
      user = users(:subscribed_business)
      pay_subscriptions(:full_time).update!(ends_at: Date.yesterday)

      render_inline UpgradeRequiredComponent.new(user)

      assert_text I18n.t("businesses.upgrade_required_component.title.expired")
      assert_text I18n.t("businesses.upgrade_required_component.body.expired")
      assert_text I18n.t("businesses.upgrade_required_component.cta.expired")
      assert_no_selector "a[href='/stripe/portal']"
    end

    test "active subscriptions see upgrade copy" do
      user = users(:subscribed_business)
      update_subscription(:part_time)

      render_inline UpgradeRequiredComponent.new(user)

      assert_text I18n.t("businesses.upgrade_required_component.title.upgrade")
      assert_text I18n.t("businesses.upgrade_required_component.body.upgrade")
      assert_text I18n.t("businesses.upgrade_required_component.cta.upgrade")
      assert_selector "a[href='/stripe/portal']"
    end
  end
end
