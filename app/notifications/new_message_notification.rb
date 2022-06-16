class NewMessageNotification < ApplicationNotification
  include IosNotification

  deliver_by :database
  deliver_by :email, mailer: "MessageMailer", method: :new_message

  param :message
  param :conversation

  def title
    t("notifications.new_message_notification.title", sender: message.sender.name)
  end

  def email_subject
    t("notifications.new_message_notification.email_subject", sender: message.sender.name)
  end

  def ios_subject
    message.body
  end

  def url
    conversation_url(conversation)
  end

  def message
    params[:message]
  end

  def conversation
    params[:conversation]
  end
end
