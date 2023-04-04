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

    @form = @notification.hiring_invoice_request
    @business = @form.business

    mail(to: recipient.email, subject: @notification.title)
  end

  def developers_celebration_package_request
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @form = @notification.celebration_package_request
    @developer = @form.developer

    mail(to: recipient.email, subject: @notification.title)
  end

  def affiliates_registration
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @user = @notification.user

    mail(to: recipient.email, subject: @notification.title)
  end
end
