class NewMessageNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "MessageMailer", method: :new_message

  param :message
end
