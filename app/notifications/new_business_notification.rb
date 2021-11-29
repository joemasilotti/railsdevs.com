class NewBusinessNotification < Noticed::Base
  deliver_by :database, debug: true
  deliver_by :email, mailer: "AdminMailer", method: :new_business

  param :business
end
