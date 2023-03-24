desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task rename_notifications: :environment do
    Notification.where(type: "Admin::NewHiredFormNotification")
      .update_all(type: Admin::Developers::NewCelebrationPackageRequestNotification.to_s)
  end
end
