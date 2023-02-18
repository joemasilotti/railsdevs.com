class AdminMailerPreview < ActionMailer::Preview
  def new_developer
    developer = User.find_by(email: "developer@example.com").developer
    notification = Notification.find_by(type: Admin::NewDeveloperNotification.to_s, params: {developer:})
    AdminMailer.with(record: notification, recipient: User.first).new_developer
  end

  def new_business
    business = User.find_by(email: "business@example.com").business
    notification = Notification.find_by(type: Admin::NewBusinessNotification.to_s, params: {business:})
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

  def new_hired_form
    notification = Notification.where(type: Admin::NewHiredFormNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_hired_form
  end
end
