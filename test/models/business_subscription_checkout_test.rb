require "test_helper"

class BusinessSubscriptionCheckoutTest < ActiveSupport::TestCase
  include PayHelper
  include Rails.application.routes.url_helpers

  test "creates a Pay::Customer for Stripe for the user" do
    user = users(:business)
    stub_pay(user) do
      assert_difference "Pay::Customer.count", 1 do
        BusinessSubscriptionCheckout.new(user:).url
      end
    end
    assert_equal Pay::Customer.last.owner, user
    assert Pay::Customer.last.stripe?
  end

  test "redirects to the success URL" do
    user = users(:business)
    success_path = "/developers/42"

    stub_pay(user) do
      assert_difference "Analytics::Event.count", 1 do
        BusinessSubscriptionCheckout.new(user:, success_path:).url
      end
      assert_equal Analytics::Event.last.url, success_path
    end
  end

  test "charges the price for the part-time, full-time, or legacy plan" do
    user = users(:business)

    part_time_price_id = Rails.application.credentials.stripe[:price_ids][:part_time_plan]
    stub_pay(user, plan_price_id: part_time_price_id) do
      BusinessSubscriptionCheckout.new(user:, plan: "part_time").url
    end

    full_time_price_id = Rails.application.credentials.stripe[:price_ids][:full_time_plan]
    stub_pay(user, plan_price_id: full_time_price_id) do
      BusinessSubscriptionCheckout.new(user:, plan: "full_time").url
    end

    legacy_price_id = Rails.application.credentials.stripe[:price_ids][:legacy_plan]
    stub_pay(user, plan_price_id: legacy_price_id) do
      BusinessSubscriptionCheckout.new(user:, plan: "legacy").url
    end
  end

  test "returns a Stripe Checkout URL" do
    user = users(:business)
    stub_pay(user) do
      url = BusinessSubscriptionCheckout.new(user:).url
      assert_equal url, "checkout.stripe.com"
    end
  end
end
