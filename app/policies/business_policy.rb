class BusinessPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def permitted_attributes
    if user.active_business_subscription?
      default_attributes + notification_attributes
    else
      default_attributes
    end
  end

  private

  def default_attributes
    [
      :name,
      :company,
      :bio,
      :avatar
    ]
  end

  def notification_attributes
    [:developer_notifications]
  end
end
