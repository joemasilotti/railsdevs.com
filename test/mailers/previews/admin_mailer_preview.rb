class AdminMailerPreview < ActionMailer::Preview
  def new_developer
    notification = Notification.find_by(type: Admin::NewDeveloperNotification.to_s)
    AdminMailer.with(record: notification, recipient: User.first).new_developer
  end

  def new_business
    notification = Notification.find_by(type: Admin::NewBusinessNotification.to_s)
    AdminMailer.with(record: notification, recipient: User.first).new_business
  end

  def new_conversation
    notification = Notification.where(type: Admin::NewConversationNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_conversation
  end

  def potential_hire
    notification = Notification.where(type: Admin::PotentialHireNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).potential_hire
  end

  def subscription_change
    notification = Notification.where(type: Admin::SubscriptionChangeNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).subscription_change
  end

  def businesses_hiring_invoice_request
    notification = Notification.where(type: Admin::Businesses::HiringInvoiceRequestNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).businesses_hiring_invoice_request
  end

  def developers_celebration_package_request
    notification = Notification.where(type: Admin::Developers::NewCelebrationPackageRequestNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).developers_celebration_package_request
  end

  def affiliates_registration
    notification = Notification.where(type: Admin::Affiliates::RegistrationNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).affiliates_registration
  end
end
