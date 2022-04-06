require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "conversations where the user is the developer" do
    user = users(:prospect_developer)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "conversations where the user is the business" do
    user = users(:subscribed_business)
    assert_equal user.conversations, [conversations(:one)]
  end

  test "blocked conversations are ignored" do
    user = users(:subscribed_business)
    assert user.conversations.include?(conversations(:one))

    conversations(:one).touch(:developer_blocked_at)
    refute user.conversations.include?(conversations(:one))
  end

  test "customer name for Pay" do
    user = users(:business)
    assert_equal user.pay_customer_name, businesses(:one).name

    user = users(:empty)
    assert_nil user.pay_customer_name
  end

  test "active business subscription" do
    user = users(:business)
    refute user.active_business_subscription?

    user.set_payment_processor(:fake_processor, allow_fake: true)
    user.payment_processor.subscribe(name: "full_time")
    assert user.reload.active_business_subscription?
  end

  test "active legacy business subscription" do
    user = users(:business)
    refute user.active_legacy_business_subscription?

    user.set_payment_processor(:fake_processor, allow_fake: true)
    user.payment_processor.subscribe(name: "legacy")
    assert user.reload.active_legacy_business_subscription?
  end
end
