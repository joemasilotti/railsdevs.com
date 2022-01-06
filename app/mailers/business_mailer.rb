class BusinessMailer < ApplicationMailer
  def new_developer_profile
    @business = params[:business]
    @developers = params[:developers]

    mail(to: @business.user.email, subject: "New developer profiles added!")
  end
end
