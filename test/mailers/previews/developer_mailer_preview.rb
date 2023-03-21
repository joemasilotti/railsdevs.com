class DeveloperMailerPreview < ActionMailer::Preview
  def profile_reminder
    notification = Notification.where(type: Developers::ProfileReminderNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).profile_reminder
  end

  def welcome
    developer = Developer.first
    DeveloperMailer.with(developer: developer).welcome
  end

  def celebration_promotion
    DeveloperMailer.with(conversation: Conversation.first).celebration_promotion
  end

  def first_message
    DeveloperMailer.with(developer: Developer.first).first_message
  end

  def product_announcement
    notification = Notification.where(type: Developers::ProductAnnouncementNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).product_announcement
  end
end
