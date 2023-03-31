class NewOfferNotification < ApplicationNotification
  include IosNotification

  deliver_by :database
  deliver_by :email, mailer: "OfferMailer", method: :new_offer

  param :offer
  param :conversation

  def title
    t("notifications.new_offer_notification.title", sender: offer.sender.name)
  end

  def email_subject
    t("notifications.new_offer_notification.email_subject", sender: offer.sender.name)
  end

  def ios_subject
    title
  end

  def url
    conversation_url(conversation)
  end

  def offer
    params[:offer]
  end

  def conversation
    params[:conversation]
  end
end
