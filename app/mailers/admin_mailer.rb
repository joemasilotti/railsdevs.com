class AdminMailer < ApplicationMailer
  def new_developer_profile
    @user = params[:recipient]
    @developer = params[:developer]
    mail(to: @user.email, subject: "New developer profile added")
  end
end
