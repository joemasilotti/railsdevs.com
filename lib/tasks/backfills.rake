desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task notifications: :environment do
    Notification.where(type: "NewDeveloperProfileNotification")
      .update_all(type: Admin::NewDeveloperNotification.to_s)

    Notification.where(type: "NewBusinessNotification")
      .update_all(type: Admin::NewBusinessNotification.to_s)

    Notification.where(type: "NewConversationNotification")
      .update_all(type: Admin::NewConversationNotification.to_s)

    Notification.where(type: "InvisiblizeDeveloperNotification")
      .update_all(type: Developers::InvisiblizeNotification.to_s)

    Notification.where(type: "PotentialHireNotification")
      .update_all(type: Admin::PotentialHireNotification.to_s)

    Notification.where(type: "StaleDeveloperNotification")
      .update_all(type: Developers::ProfileReminderNotification.to_s)
  end
end
