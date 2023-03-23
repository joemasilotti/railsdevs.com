class AdminMailer < ApplicationMailer
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
    @message = conversation.messages.first

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

  def subscription_change
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @business = @notification.subscription.customer.owner.business

    mail(to: recipient.email, subject: @notification.title)
  end

  def businesses_hiring_invoice_request
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @form = @notification.form
    @business = @form.business

    mail(to: recipient.email, subject: @notification.title)
  end

  def new_hired_form
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @form = @notification.form
    @developer = @form.developer

    mail(to: recipient.email, subject: @notification.title)
  end
end
