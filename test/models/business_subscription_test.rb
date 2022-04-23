require "test_helper"

class BusinessSubscriptionTest < ActiveSupport::TestCase
  include BusinessSubscription

  test "finding a plan by name" do
    assert_instance_of FullTime, BusinessSubscription.new("full_time")
    assert_instance_of Legacy, BusinessSubscription.new("legacy")
    assert_instance_of PartTime, BusinessSubscription.new("part_time")

    assert_instance_of PartTime, BusinessSubscription.new("foo-bar")
  end

  test "finding a plan by price" do
    assert_instance_of FullTime, BusinessSubscription.from(price_ids[:full_time_plan])
    assert_instance_of Legacy, BusinessSubscription.from(price_ids[:legacy_plan])
    assert_instance_of PartTime, BusinessSubscription.from(price_ids[:part_time_plan])

    assert_raises UnknownPrice do
      BusinessSubscription.from("invalid_price")
    end
  end

  test "all plans have prices and names" do
    [FullTime, PartTime, Legacy].each do |klass|
      plan = klass.new
      assert_not_nil plan.price
      assert_not_nil plan.name
    end
  end

  def price_ids
    Rails.application.credentials.stripe.price_ids
  end
end
