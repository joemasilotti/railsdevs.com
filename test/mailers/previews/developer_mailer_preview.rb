class DeveloperMailerPreview < ActionMailer::Preview
  def profile_reminder
    notification = Notification.where(type: Developers::ProfileReminderNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).profile_reminder
  end

  def welcome
    notification = Notification.where(type: Developers::WelcomeNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).welcome
  end

  def first_message
    DeveloperMailer.with(developer: Developer.first).first_message
  end
end
