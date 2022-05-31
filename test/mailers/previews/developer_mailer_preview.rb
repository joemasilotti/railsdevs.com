class DeveloperMailerPreview < ActionMailer::Preview
  def invisiblize
    notification = Notification.where(type: InvisiblizeDeveloperNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).invisiblize
  end

  def stale
    notification = Notification.where(type: StaleDeveloperNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).stale
  end

  def welcome
    notification = Notification.where(type: WelcomeDeveloperNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).welcome
  end
end
