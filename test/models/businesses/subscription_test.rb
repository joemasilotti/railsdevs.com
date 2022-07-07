require "test_helper"

class Businesses::SubscriptionTest < ActiveSupport::TestCase
  test "finds a subscription by identifier" do
    subscription = Businesses::Subscription.with_identifier("full_time")
    assert_equal "Full-time", subscription.name
    assert_equal 299, subscription.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", subscription.stripe_price_id
    assert_equal "full_time_plan_identifier", subscription.revenue_cat_product_identifier
  end

  test "finds all subscriptions" do
    identifiers = %w[free legacy part_time full_time]

    identifiers.each do |identifier|
      assert_not_nil Businesses::Subscription.with_identifier(identifier)
    end
  end

  test "raises if the identifier doesn't match any subscriptions" do
    assert_raises Businesses::Subscription::UnknownSubscription do
      Businesses::Subscription.with_identifier(:foo_bar)
    end
  end

  test "finds a subscription by Stripe price ID" do
    subscription = Businesses::Subscription.with_processor_plan("price_FAKE_FULL_TIME_PLAN_PRICE_ID")
    assert_equal "Full-time", subscription.name
    assert_equal 299, subscription.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", subscription.stripe_price_id
  end

  test "finds a subscription by RevenueCat product identifier" do
    subscription = Businesses::Subscription.with_processor_plan("full_time_plan_identifier")
    assert_equal "Full-time", subscription.name
    assert_equal 299, subscription.price
    assert_equal "full_time_plan_identifier", subscription.revenue_cat_product_identifier
  end

  test "raises if the processor plan doesn't match any subscriptions" do
    assert_raises Businesses::Subscription::UnknownSubscription do
      Businesses::Subscription.with_processor_plan(:unknown_price)
    end
  end
end
