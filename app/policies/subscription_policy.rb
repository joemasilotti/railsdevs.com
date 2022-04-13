class SubscriptionPolicy < ApplicationPolicy
  def messageable?
    !(part_time_subscription? && only_full_time_employment?)
  end

  private

  def part_time_subscription?
    business.user.active_part_time_business_subscription?
  end

  def only_full_time_employment?
    developer.role_type.only_full_time_employment?
  end

  def business
    record.conversation.business
  end

  def developer
    record.conversation.developer
  end
end
