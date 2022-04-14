class WelcomeMailer < ApplicationMailer
  default from: "joe@masilotti.com"
  helper :messages


  def developer_welcome_email
    @developer = params[:developer]
    mail(to: @developer.user.email, subject: "Welcome to railsdevs!")
  end

  def business_welcome_email 
    @business = params[:business]
    mail(to: @business.user.email, subject: "Welcome to railsdevs!")
  end
end
