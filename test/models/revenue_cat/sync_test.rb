require "test_helper"

class RevenueCat::SyncTest < ActiveSupport::TestCase
  test "RevenueCat subscribers have active Pay subscriptions" do
    user = users(:empty)

    stub_request(:get, "https://api.revenuecat.com/v1/subscribers/#{user.id}")
      .to_return(body: subscriber_response.to_json)

    event = {app_user_id: user.id}
    assert_changes "user.subscriptions.count", 1 do
      RevenueCat::Sync.new(event).sync_subscriptions
    end
    assert_equal Time.parse("2022-08-01T18:27:49Z"), Pay::Subscription.last.ends_at
  end

  def subscriber_response
    {
      request_date: "2022-07-01T18:59:49Z",
      request_date_ms: 1656701989532,
      subscriber: {
        entitlements: {
          "Business subscription": {
            expires_date: "2022-08-01T18:27:49Z",
            grace_period_expires_date: nil,
            product_identifier: "full_time_plan",
            purchase_date: "2022-07-01T18:27:49Z"
          }
        },
        first_seen: "2022-07-01T18:27:10Z",
        last_seen: "2022-07-01T18:27:31Z",
        management_url: "https://apps.apple.com/account/subscriptions",
        non_subscriptions: {},
        original_app_user_id: "$RCAnonymousID:5d16a522e57e4553b0ca46c96bf2e29f",
        original_application_version: "1.0",
        original_purchase_date: "2022-07-01T18:27:49Z",
        other_purchases: {},
        subscriptions: {
          full_time_plan: {
            billing_issues_detected_at: nil,
            expires_date: "2022-08-01T18:27:49Z",
            grace_period_expires_date: nil,
            is_sandbox: true,
            original_purchase_date: "2022-07-01T18:27:49Z",
            period_type: "normal",
            purchase_date: "2022-07-01T18:27:49Z",
            store: "app_store",
            unsubscribe_detected_at: nil
          }
        }
      }
    }
  end

  def nonsubscriber_response
    {
      request_date: "2022-07-01T18:59:29Z",
      request_date_ms: 1656701969746,
      subscriber:
      {
        entitlements: {},
        first_seen: "2022-07-01T18:59:17Z",
        last_seen: "2022-07-01T18:59:17Z",
        management_url: nil,
        non_subscriptions: {},
        original_app_user_id: "1",
        original_application_version: nil,
        original_purchase_date: nil,
        other_purchases: {},
        subscriptions: {}
      }
    }
  end

  def webhook_event_from_simulator
    {
      event_timestamp_ms: 1656700072241,
      product_id: "full_time_plan",
      period_type: "NORMAL",
      purchased_at_ms: 1656700069000,
      expiration_at_ms: 1659378469000,
      environment: "SANDBOX",
      entitlement_id: nil,
      entitlement_ids: ["Business subscription"],
      presented_offering_id: nil,
      transaction_id: "StoreKitTest_Transaction_1656700069000_0",
      original_transaction_id: "StoreKitTest_Transaction_1656700069000_0",
      is_family_share: false,
      country_code: "US",
      app_user_id: "30",
      aliases: ["$RCAnonymousID:5d16a522e57e4553b0ca46c96bf2e29f", "30"],
      original_app_user_id: "$RCAnonymousID:5d16a522e57e4553b0ca46c96bf2e29f",
      currency: "USD",
      price: 299.99,
      price_in_purchased_currency: 299.99,
      subscriber_attributes: {
        "$attConsentStatus": {
          value: "notDetermined",
          updated_at_ms: 1656700071504
        }
      },
      store: "APP_STORE",
      takehome_percentage: 0.85,
      offer_code: nil,
      type: "INITIAL_PURCHASE",
      id: "298AA80F-5F14-4BD3-BFC0-1E7E9CF20309",
      app_id: "appd6fba67a08"
    }
  end
end
