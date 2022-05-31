class DeveloperMailerPreview < ActionMailer::Preview
  def invisiblize
    notification = Notification.where(type: Developers::InvisiblizeNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).invisiblize
  end

  def stale
    notification = Notification.where(type: Developers::ProfileReminderNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).stale
  end

  def welcome
    notification = Notification.where(type: Developers::WelcomeNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).welcome
  end
end
