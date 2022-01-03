class AdminMailer < ApplicationMailer
  def new_developer_profile
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer.name

    mail(to: recipient.email, subject: "New developer profile added")
  end

  def new_business
    @notification = params[:record]
    recipient = params[:recipient]

    @business = @notification.to_notification.business.name

    mail(to: recipient.email, subject: "New business added")
  end

  def new_conversation
    @notification = params[:record]
    recipient = params[:recipient]

    instance = @notification.to_notification
    @name = instance.conversation.business.name
    @company = instance.conversation.business.company
    @developer = instance.conversation.developer.name

    mail(to: recipient.email, subject: "New conversation started")
  end
end
