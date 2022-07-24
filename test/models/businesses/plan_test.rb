require "test_helper"

class Businesses::PlanTest < ActiveSupport::TestCase
  test "finds a plan by identifier" do
    plan = Businesses::Plan.with_identifier("full_time")
    assert_equal "Full-time", plan.name
    assert_equal 299, plan.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", plan.stripe_price_id
    assert_equal "full_time_plan_identifier", plan.revenue_cat_product_identifier
  end

  test "finds all plans" do
    identifiers = %w[free legacy part_time full_time]

    identifiers.each do |identifier|
      assert_not_nil Businesses::Plan.with_identifier(identifier)
    end
  end

  test "raises if the identifier doesn't match any plans" do
    assert_raises Businesses::Plan::UnknownPlan do
      Businesses::Plan.with_identifier(:foo_bar)
    end
  end

  test "finds a plan by Stripe price ID" do
    plan = Businesses::Plan.with_processor_plan("price_FAKE_FULL_TIME_PLAN_PRICE_ID")
    assert_equal "Full-time", plan.name
    assert_equal 299, plan.price
    assert_equal "price_FAKE_FULL_TIME_PLAN_PRICE_ID", plan.stripe_price_id
  end

  test "finds a plan by RevenueCat product identifier" do
    plan = Businesses::Plan.with_processor_plan("full_time_plan_identifier")
    assert_equal "Full-time", plan.name
    assert_equal 299, plan.price
    assert_equal "full_time_plan_identifier", plan.revenue_cat_product_identifier
  end

  test "raises if the processor plan doesn't match any plans" do
    assert_raises Businesses::Plan::UnknownPlan do
      Businesses::Plan.with_processor_plan(:unknown_price)
    end
  end
end
