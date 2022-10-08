require "test_helper"

class Pay::SubscriptionChangesTest < ActiveSupport::TestCase
  test "subscribed: processor_plan nil -> present" do
    subscription = create_subscription!
    change = Pay::SubscriptionChanges.new(subscription).change
    assert_equal :subscribed, change
  end

  test "churned: ends_at nil -> present" do
    subscription = create_subscription!
    subscription.update!(ends_at: Date.tomorrow)

    change = Pay::SubscriptionChanges.new(subscription).change

    assert_equal :churned, change
  end

  test "resubscribed: ends_at present -> nil" do
    subscription = create_subscription!(ends_at: Date.tomorrow)
    subscription.update!(ends_at: nil)

    change = Pay::SubscriptionChanges.new(subscription).change

    assert_equal :resubscribed, change
  end

  test "plan_changed: processor_plan present -> present" do
    subscription = create_subscription!
    subscription.update!(processor_plan: :new_plan)

    change = Pay::SubscriptionChanges.new(subscription).change

    assert_equal :plan_changed, change
  end

  test "paused: pause_behavior nil -> present" do
    subscription = create_subscription!
    subscription.update!(data: {
      pause_behavior: :void
    })

    change = Pay::SubscriptionChanges.new(subscription).change

    assert_equal :paused, change
  end

  test "unpaused: pause_behavior present -> nil" do
    subscription = create_subscription!(pause_behavior: :void)
    subscription.update!(data: {
      pause_behavior: nil
    })

    change = Pay::SubscriptionChanges.new(subscription).change

    assert_equal :unpaused, change
  end

  test "unknown changes -> error" do
    subscription = create_subscription!(pause_behavior: :void)
    subscription.update!(data: nil)

    assert_raises Pay::SubscriptionChanges::UnknownSubscriptionChange do
      Pay::SubscriptionChanges.new(subscription).change
    end
  end

  def create_subscription!(ends_at: nil, pause_behavior: nil)
    Pay::Subscription.create!(
      customer: pay_customers(:one),
      name: "sub_name",
      processor_id: :sub_id,
      processor_plan: :processor_plan,
      status: :active,
      ends_at: ends_at,
      data: {
        pause_behavior: pause_behavior
      }
    )
  end
end
