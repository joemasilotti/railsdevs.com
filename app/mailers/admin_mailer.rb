class AdminMailer < ApplicationMailer
  helper :messages

  def new_developer
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @developer = @notification.developer

    mail(to: recipient.email, subject: @notification.email_subject)
  end

  def new_business
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @business = @notification.business

    mail(to: recipient.email, subject: @notification.email_subject)
  end

  def new_conversation
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    conversation = @notification.conversation
    @business = conversation.business
    @developer = conversation.developer
    @subscriptions = @business.user.subscriptions
    @body = conversation.messages.first.body

    mail(to: recipient.email, subject: @notification.email_subject)
  end

  def potential_hire
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @developer = @notification.developer
    @conversations = @developer.conversations.count
    @replies = @developer.messages.distinct.count(:conversation_id)

    mail(to: recipient.email, subject: @notification.email_subject)
  end
end
