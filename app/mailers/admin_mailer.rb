class AdminMailer < ApplicationMailer
  def new_developer_profile
    @user = params[:recipient]
    @developer = params[:developer]
    mail(to: @user.email, subject: "New developer profile added")
  end

  def new_business
    @user = params[:recipient]
    @business = params[:business]
    mail(to: @user.email, subject: "New business added")
  end

  def new_conversation
    @user = params[:recipient]
    @conversation = params[:conversation]
    mail(to: @user.email, subject: "New conversation started")
  end
end
