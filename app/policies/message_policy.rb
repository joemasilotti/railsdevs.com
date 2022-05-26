class MessagePolicy < ApplicationPolicy
  def create?
    return true if developer_recipient?

    return false unless business_recipient?
    return false unless user.active_business_subscription?

    business_subscription_can_messge_developer?
  end

  private

  def developer_recipient?
    user.developer == developer
  end

  def business_recipient?
    user.business == business
  end

  def business_subscription_can_messge_developer?
    !(part_time_subscription? && only_full_time_employment?)
  end

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
