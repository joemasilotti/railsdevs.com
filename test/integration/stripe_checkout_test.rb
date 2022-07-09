require "test_helper"

class StripeCheckoutTest < ActionDispatch::IntegrationTest
  include PayHelper

  setup do
    @user = users(:business)
  end

  test "passes along the plan and redirects to the Stripe Checkout URL" do
    sign_in @user
    full_time_price_id = Businesses::Plan.with_identifier(:full_time).stripe_price_id

    stub_pay(@user, plan_price_id: full_time_price_id) do
      post stripe_checkout_path(plan: :full_time)
      assert_redirected_to "checkout.stripe.com"
    end
  end

  test "redirects to the stored location on success" do
    success_path = new_developer_message_path(Developer.first)
    get success_path
    sign_in @user

    stub_pay(@user) do
      post stripe_checkout_path(plan: :part_time)
      assert_equal Analytics::Event.last.url, success_path
    end
  end
end
