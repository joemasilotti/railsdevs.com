class NewBusinessNotification < ApplicationNotification
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :new_business

  param :business

  def title
    t "notifications.new_business", business: business.contact_name
  end

  def url
    business_path(business)
  end

  def business
    params[:business]
  end
end
