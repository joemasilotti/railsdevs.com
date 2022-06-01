desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task apology: :environment do
    Developer.find_each do |developer|
      notifications = developer.user.notifications
        .where(type: Developers::ProfileReminderNotification.name)
      if notifications.count > 1
        notifications.last.destroy
        DeveloperMailer.with(developer:).apology.deliver_later
      end
    end
  end
end
