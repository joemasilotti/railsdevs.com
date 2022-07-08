class BusinessPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  def show?
    record.visible? || record_owner?
  end

  def permitted_attributes
    if Businesses::Permission.new(user.subscriptions).active_subscription?
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
