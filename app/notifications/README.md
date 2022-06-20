# Notifications

If a notification model (anything in `app/notifications/`) is renamed then existing notification records need to be updated.

> Otherwise, `#to_notification` will raise an exception because it can't find the class to convert to.

For example, if `NewDeveloperProfileNotification` is renamed to `Admin::NewDeveloperNotification` then the following data migration will need to be run.

```ruby
Notification.where(type: "NewDeveloperProfileNotification")
  .update_all(type: Admin::NewDeveloperNotification.to_s)
```

This can be added to `lib/tasks/backfills.rake` as a new task and manually run via the Heroku CLI.

## iOS notifications (APNs)

To send a push notification via APNs to iOS devices, add the following to the notification class.

```ruby
include IosNotification
```

Also, make sure that the following methods are implemented: `#title`, `#ios_subject`, and `#url`.

### iOS Simulator

You can send notifications to the iOS simulator with a .apns file.

Boot the iOS app, sign in as `developer@example.com`, and run the following command to send a notification.

Change `com.masilotti.railsdevs.io` to your app's bundle identifier, if different.

```
xcrun simctl push booted com.masilotti.railsdevs.ios app/notifications/notification.apns
```
