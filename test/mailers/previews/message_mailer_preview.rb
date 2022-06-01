class MessageMailerPreview < ActionMailer::Preview
  def new_message
    notification = Notification.where(type: NewMessageNotification.to_s).first
    MessageMailer.with(record: notification, recipient: notification.recipient).new_message
  end

  def first_message
    developer = Developer.first
    MessageMailer.with(developer:).first_message
  end
end
