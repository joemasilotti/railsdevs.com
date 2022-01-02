require "test_helper"

class BusinessSubscriptionCheckoutTest < ActiveSupport::TestCase
  include PayHelper
  include Rails.application.routes.url_helpers

  test "creates a Pay::Customer for Stripe for the user" do
    user = users(:with_business)
    stub_pay(user) do
      assert_changes "Pay::Customer.count", 1 do
        BusinessSubscriptionCheckout.new(user).url
      end
    end
    assert_equal Pay::Customer.last.owner, user
    assert Pay::Customer.last.stripe?
  end

  test "redirects to sending a developer message if a developer is given" do
    user = users(:with_business)
    developer = developers(:available)

    stub_pay(user, expected_success_url: new_developer_message_url(developer)) do
      BusinessSubscriptionCheckout.new(user, developer: developer).url
    end
  end

  test "redirects to conversations if the user has a business profile" do
    user = users(:with_business)
    stub_pay(user, expected_success_url: conversations_url) do
      BusinessSubscriptionCheckout.new(user).url
    end
  end

  test "redirects to adding a business profile if the user doesn't have one" do
    user = users(:empty)
    stub_pay(user, expected_success_url: new_business_url) do
      BusinessSubscriptionCheckout.new(user).url
    end
  end

  test "returns a Stripe Checkout URL" do
    user = users(:with_business)
    stub_pay(user) do
      url = BusinessSubscriptionCheckout.new(user).url
      assert_equal url, "checkout.stripe.com"
    end
  end
end
