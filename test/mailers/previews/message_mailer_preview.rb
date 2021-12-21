class MessageMailerPreview < ActionMailer::Preview
  def new_message
    MessageMailer.with(message: Message.first).new_message
  end
end
