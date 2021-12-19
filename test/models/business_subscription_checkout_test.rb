require "test_helper"

class BusinessSubscriptionCheckoutTest < ActiveSupport::TestCase
  test "sets Stripe as the payment processor"
  test "builds a subscription Stripe Checkout"
  test "redirects to sending a developer message if a developer is given"
  test "redirects to conversations if the user has a business profile"
  test "redirects to adding a business profile if the user doesn't have one"
  test "returns a Stripe Checkout URL"
end
