require "test_helper"

class Businesses::PermissionTest < ActiveSupport::TestCase
  include SubscriptionsHelper

  test "active_subscription? if any subscriptions are active" do
    customer = pay_customers(:one)
    permission = Businesses::Permission.new(customer)
    assert permission.active_subscription?

    pay_subscriptions(:full_time).update!(status: :cancelled)
    permission = Businesses::Permission.new(customer)
    refute permission.active_subscription?
  end

  test "no active_subscription? if paused and active subscription has ended" do
    customer = pay_customers(:one)

    pay_subscriptions(:full_time).update!(status: "paused")
    assert Businesses::Permission.new(customer).active_subscription?

    pay_subscriptions(:full_time).update!(ends_at: Date.tomorrow)
    assert Businesses::Permission.new(customer).active_subscription?

    pay_subscriptions(:full_time).update!(ends_at: Date.yesterday)
    refute Businesses::Permission.new(customer).active_subscription?
  end

  test "legacy_subscription? if any active subscriptions are legacy" do
    customer = pay_customers(:one)
    permission = Businesses::Permission.new(customer)
    refute permission.legacy_subscription?

    update_subscription(:legacy)
    permission = Businesses::Permission.new(customer)
    assert permission.legacy_subscription?
  end

  test "required to pay hiring fee for full-time subscriptions" do
    customer = pay_customers(:one)
    permission = Businesses::Permission.new(customer)
    assert permission.pays_hiring_fee?

    update_subscription(:part_time)
    permission = Businesses::Permission.new(customer)
    refute permission.pays_hiring_fee?
  end

  test "part-time subscriptions can't message developers only looking for full-time roles" do
    customer = pay_customers(:one)
    update_subscription(:part_time)
    permission = Businesses::Permission.new(customer)
    assert permission.can_message_developer?(role_type: part_time_role_type)
    refute permission.can_message_developer?(role_type: full_time_role_type)
    assert permission.can_message_developer?(role_type: flexible_role_type)
  end

  test "full-time, legacy, and free subscriptions can message any developer" do
    customer = pay_customers(:one)
    permission = Businesses::Permission.new(customer)
    assert permission.can_message_developer?(role_type: part_time_role_type)
    assert permission.can_message_developer?(role_type: full_time_role_type)
    assert permission.can_message_developer?(role_type: flexible_role_type)

    update_subscription(:legacy)
    permission = Businesses::Permission.new(customer)
    assert permission.can_message_developer?(role_type: part_time_role_type)
    assert permission.can_message_developer?(role_type: full_time_role_type)
    assert permission.can_message_developer?(role_type: flexible_role_type)

    update_subscription(:free)
    permission = Businesses::Permission.new(customer)
    assert permission.can_message_developer?(role_type: part_time_role_type)
    assert permission.can_message_developer?(role_type: full_time_role_type)
    assert permission.can_message_developer?(role_type: flexible_role_type)
  end

  test "inactive subscriptions can't message anyone" do
    permission = Businesses::Permission.new(Pay::Customer.new)
    refute permission.can_message_developer?(role_type: part_time_role_type)
    refute permission.can_message_developer?(role_type: full_time_role_type)
    refute permission.can_message_developer?(role_type: flexible_role_type)
  end

  test "no subscriptions doesn't raise" do
    permission = Businesses::Permission.new(nil)

    refute permission.active_subscription?
    refute permission.legacy_subscription?
    refute permission.pays_hiring_fee?
    refute permission.can_message_developer?(role_type: nil)
  end

  def part_time_role_type
    RoleType.new(part_time_contract: true)
  end

  def full_time_role_type
    RoleType.new(full_time_employment: true)
  end

  def flexible_role_type
    RoleType.new(part_time_contract: true, full_time_employment: true)
  end
end
