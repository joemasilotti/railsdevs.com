require "test_helper"

class SubscriptionPolicyTest < ActiveSupport::TestCase
  include SubscriptionsHelper

  setup do
    @conversation = conversations(:one)
    @user = @conversation.business.user
    @record = @conversation.messages.first
  end

  test "not messageable if on part-time plan and developer ONLY wants full-time employment" do
    update_subscription(:part_time)

    @conversation.developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    refute SubscriptionPolicy.new(@user, @record).messageable?
  end

  test "is messageable if on full-time plan" do
    @conversation.developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    assert SubscriptionPolicy.new(@user, @record).messageable?
  end

  test "is messageable if developer is looking for a part-time role" do
    @conversation.developer.role_type.update!(
      full_time_contract: true,
      full_time_employment: true
    )

    assert SubscriptionPolicy.new(@user, @record).messageable?
  end
end
