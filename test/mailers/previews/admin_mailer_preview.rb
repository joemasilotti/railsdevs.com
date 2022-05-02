class AdminMailerPreview < ActionMailer::Preview
  def new_developer_profile
    notification = Notification.where(type: NewDeveloperProfileNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_developer_profile
  end

  def new_business
    notification = Notification.where(type: NewBusinessNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_business
  end

  def new_conversation
    notification = Notification.where(type: NewConversationNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).new_conversation
  end

  def potential_hire
    notification = Notification.where(type: PotentialHireNotification.to_s).first
    AdminMailer.with(record: notification, recipient: User.first).potential_hire
  end
end
