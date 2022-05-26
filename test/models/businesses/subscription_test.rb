require "test_helper"

class Businesses::SubscriptionTest < ActiveSupport::TestCase
  test "finds a subscription by identifier" do
    subscription = Businesses::Subscription.with_identifier("full_time")
    assert_equal "Full-time", subscription.name
    assert_equal 299, subscription.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", subscription.price_id
  end

  test "finds all subscriptions" do
    identifiers = %w[free legacy part_time full_time]

    identifiers.each do |identifier|
      subscription = Businesses::Subscription.with_identifier(identifier)
      assert_not_nil subscription.name
      assert_not_nil subscription.price
      assert_not_nil subscription.price_id
    end
  end

  test "raises if the identifier doesn't match any subscriptions" do
    assert_raises Businesses::Subscription::UnknownSubscription do
      Businesses::Subscription.with_identifier(:foo_bar)
    end
  end

  test "finds a subscription by price ID" do
    subscription = Businesses::Subscription.with_price_id("price_FAKE_FULL_TIME_PLAN_PRICE_ID")
    assert_equal "Full-time", subscription.name
    assert_equal 299, subscription.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", subscription.price_id
  end

  test "finds all subscriptions by price ID" do
    price_ids = %w[
      default
      price_FAKE_LEGACY_PLAN_PRICE_ID
      price_FAKE_PART_TIME_PLAN_PRICE_ID
      price_FAKE_FULL_TIME_PLAN_PRICE_ID
    ]

    price_ids.each do |price_id|
      subscription = Businesses::Subscription.with_price_id(price_id)
      assert_not_nil subscription.name
      assert_not_nil subscription.price
      assert_not_nil subscription.price_id
    end
  end

  test "raises if the price ID doesn't match any subscriptions" do
    assert_raises Businesses::Subscription::UnknownSubscription do
      Businesses::Subscription.with_price_id(:unknown_price)
    end
  end

  def price_ids
    Rails.application.credentials.stripe.price_ids
  end
end
