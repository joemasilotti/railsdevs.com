class BusinessMailer < ApplicationMailer
  delegate :pluralize, to: "ActionController::Base.helpers"

  def developer_profiles
    @business = params[:business]
    @developers = params[:developers]
    subject = "#{pluralize(@developers.count, "new developer profile")} added to railsdevs"

    mail(to: @business.user.email, subject:, from: Rails.configuration.notifications_email)
  end
end
