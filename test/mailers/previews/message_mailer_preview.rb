class MessageMailerPreview < ActionMailer::Preview
  def new_message
    notification = Message.first.notifications_as_message.first
    MessageMailer.with(record: notification).new_message
  end
end
