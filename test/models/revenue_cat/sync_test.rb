require "test_helper"

class RevenueCat::SyncTest < ActiveSupport::TestCase
  test "creates a new full-time plan subscription" do
    user = users(:empty)

    stub_request(:get, "https://api.revenuecat.com/v1/subscribers/#{user.id}")
      .to_return(body: subscriber_response.to_json)

    assert_changes "user.subscriptions.count", 1 do
      RevenueCat::Sync.new(user.id).sync_subscriptions
    end

    subscription = Pay::Subscription.last
    assert_equal plan_for(:full_time).revenue_cat_product_identifier, subscription.processor_plan
    assert_equal Date.tomorrow.to_time, subscription.ends_at
  end

  test "creates a new part-time plan subscription" do
    user = users(:empty)

    stub_request(:get, "https://api.revenuecat.com/v1/subscribers/#{user.id}")
      .to_return(body: subscriber_response(plan: :part_time).to_json)

    assert_changes "user.subscriptions.count", 1 do
      RevenueCat::Sync.new(user.id).sync_subscriptions
    end

    subscription = Pay::Subscription.last
    assert_equal plan_for(:part_time).revenue_cat_product_identifier, subscription.processor_plan
    assert_equal Date.tomorrow.to_time, subscription.ends_at
  end

  test "updates expires date for existing subscriptions" do
    user = users(:empty)
    expires_at = Date.yesterday.to_time

    stub_request(:get, "https://api.revenuecat.com/v1/subscribers/#{user.id}")
      .to_return(body: subscriber_response(expires_at:).to_json)

    RevenueCat::Sync.new(user.id).sync_subscriptions
    assert_no_changes "user.subscriptions.count" do
      RevenueCat::Sync.new(user.id).sync_subscriptions
    end
    assert_equal expires_at, Pay::Subscription.last.ends_at
  end

  def subscriber_response(plan: :full_time, expires_at: Date.tomorrow.to_time)
    {
      subscriber: {
        entitlements: {
          "Business subscription": {
            expires_date: expires_at.to_formatted_s(:iso8601),
            product_identifier: plan_for(plan).revenue_cat_product_identifier
          }
        }
      }
    }
  end

  def plan_for(identifier)
    Businesses::Plan.with_identifier(identifier)
  end
end
