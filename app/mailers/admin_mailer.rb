class AdminMailer < ApplicationMailer
  helper :messages

  def new_developer_profile
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(to: recipient.email, subject: "New developer profile added")
  end

  def new_business
    @notification = params[:record]
    recipient = params[:recipient]

    @business = @notification.to_notification.business

    mail(to: recipient.email, subject: "New business added")
  end

  def new_conversation
    @notification = params[:record]
    recipient = params[:recipient]

    conversation = @notification.to_notification.conversation
    @business = conversation.business
    @developer = conversation.developer
    @subscriptions = @business.user.subscriptions
    @body = conversation.messages.first.body

    mail(to: recipient.email, subject: "New conversation started")
  end

  def potential_hire
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer
    @conversations = @developer.conversations.count
    @replies = @developer.messages.distinct.count(:conversation_id)

    mail(to: recipient.email, subject: "New potential hire")
  end
end
