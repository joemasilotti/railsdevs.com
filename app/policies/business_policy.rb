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
      :contact_name,
      :company,
      :bio,
      :avatar,
      :website,
      :contact_role
    ]
  end

  def notification_attributes
    [:developer_notifications]
  end
end
