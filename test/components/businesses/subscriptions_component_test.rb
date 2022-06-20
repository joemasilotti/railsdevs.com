require "test_helper"

module Businesses
  class SubscriptionsComponentTest < ViewComponent::TestCase
    test "renders for admins" do
      business = businesses(:subscriber)

      user = nil
      render_inline SubscriptionsComponent.new(business, user:)
      assert_no_selector "*"

      user = users(:developer)
      render_inline SubscriptionsComponent.new(business, user:)
      assert_no_selector "*"

      user = users(:admin)
      render_inline SubscriptionsComponent.new(business, user:)
      assert_selector "dl"
    end

    test "renders a Stripe link for Stripe customers" do
      business = businesses(:subscriber)
      user = users(:admin)

      render_inline SubscriptionsComponent.new(business, user:)
      assert_selector "a"

      business.user.payment_processor.update!(processor: :fake)
      render_inline SubscriptionsComponent.new(business, user:)
      assert_no_selector "a"
    end

    test "links to production or test Stripe dashboard" do
      business = businesses(:subscriber)
      user = users(:admin)

      render_inline SubscriptionsComponent.new(business, user:)
      assert_selector "a[href*='stripe.com/customers']"

      business.user.payment_processor.update!(processor_id: "not_stripe_1234")
      render_inline SubscriptionsComponent.new(business, user:)
      assert_selector "a[href*='stripe.com/test/customers']"
    end
  end
end
