module Admin
  class NewConversationNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_conversation

    param :conversation

    def title
      t("notifications.admin.new_conversation_notification.title",
        name: conversation.business.contact_name,
        company: conversation.business.company,
        developer: conversation.developer.name)
    end

    def url
      conversation_path(conversation)
    end

    def conversation
      params[:conversation]
    end
  end
end
