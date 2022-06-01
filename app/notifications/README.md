# Notifications

If a notification model (anything in `app/notifications/`) is renamed then existing notification records need to be updated.

> Otherwise, `#to_notification` will raise an exception because it can't find the class to convert to.

For example, if `NewDeveloperProfileNotification` is renamed to `Admin::NewDeveloperNotification` then the following data migration will need to be run.

```ruby
Notification.where(type: "NewDeveloperProfileNotification")
  .update_all(type: Admin::NewDeveloperNotification.to_s)
```

This can be added to `lib/tasks/backfills.rake` as a new task and manually run via the Heroku CLI.
