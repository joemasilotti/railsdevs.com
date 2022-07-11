require "test_helper"

class Webhooks::RevenueCatControllerTest < ActionDispatch::IntegrationTest
  test "valid authorization header enqueues the sync job" do
    assert_enqueued_with(job: RevenueCatSubscriptionsSyncJob, args: ["42"]) do
      post webhooks_revenuecat_path, params:, headers: {
        Authorization: valid_authorization
      }
    end

    assert_response :ok
  end

  test "invalid authorization is unauthorized" do
    assert_no_enqueued_jobs do
      post webhooks_revenuecat_path, params:, headers: {
        Authorization: "invalid-auth-token"
      }
    end

    assert_response :unauthorized
  end

  def params
    {
      event: {
        app_user_id: 42
      }
    }
  end

  def valid_authorization
    Rails.application.credentials.revenue_cat.webhook_authorization
  end
end
