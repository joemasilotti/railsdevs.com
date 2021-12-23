class NewConversationNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :new_conversation

  param :conversation
end
