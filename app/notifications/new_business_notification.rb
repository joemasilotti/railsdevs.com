class NewBusinessNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "AdminMailer", method: :new_business

  param :business

  def business
    params[:business]
  end
end
