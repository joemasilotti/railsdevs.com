class DeveloperMailerPreview < ActionMailer::Preview
  def inivisiblize
    notification = Notification.where(type: InvisiblizeDeveloperNotification.to_s).first
    DeveloperMailer.with(record: notification, recipient: notification.recipient).flagged
  end
end
