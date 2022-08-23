module Developers
  class CelebrationPromotionNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "DeveloperMailer", method: :celebration_promotion, delay: 30.days

    param :conversation

    def title
      "How's your conversation going with #{business.contact_name} at #{business.company}?"
    end

    def url
      conversation_url(conversation)
    end

    def conversation
      params[:conversation]
    end

    def business
      conversation.business
    end
  end
end
