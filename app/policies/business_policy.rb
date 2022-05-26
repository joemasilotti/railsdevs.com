class BusinessPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  params_filter do |params|
    params.permit(permitted_attributes)
  end

  private

  def permitted_attributes
    if user.active_business_subscription?
      default_attributes + notification_attributes
    else
      default_attributes
    end
  end

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
