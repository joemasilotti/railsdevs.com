# To deliver this notification:
#
# NewDeveloperProfileNotification.with(developer: @developer).deliver_later(current_user)
# NewDeveloperProfileNotification.with(developer: @developer).deliver(current_user)

class NewDeveloperProfileNotification < Noticed::Base
  deliver_by :database, debug: true
  deliver_by :email, mailer: "AdminMailer", method: :new_developer_profile

  param :developer
end
