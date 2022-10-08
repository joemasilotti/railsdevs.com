class AdminMailerPreview < ActionMailer::Preview
  def new_developer
    notification = Notification.where(type: Admin::NewDeveloperNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_developer
  end

  def new_business
    notification = Notification.where(type: Admin::NewBusinessNotification.to_s).first
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
