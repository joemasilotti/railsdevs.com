class NewDeveloperProfileNotification < Noticed::Base
  deliver_by :database, debug: true
  deliver_by :email, mailer: "AdminMailer", method: :new_developer_profile

  param :developer
end
