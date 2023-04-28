class OfferDeclinedNotification < ApplicationNotification
  include IosNotification

  deliver_by :database
  deliver_by :email, mailer: "OfferMailer", method: :offer_declined_notification

  param :offer
  param :conversation

  def title
    t("notifications.offer_declined_notification.title", receiver: offer.receiver.name)
  end

  def email_subject
    t("notifications.offer_declined_notification.email_subject", receiver: offer.receiver.name)
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
