class StaleDevelopersQuery
  EARLIEST_TIME = 30.days.ago.beginning_of_day

  def stale_and_not_recently_notified
    Developer.actively_looking_or_open
      .where(updated_at: ..EARLIEST_TIME)
      .where(no_recent_notifications)
  end

  private

  def no_recent_notifications
    developers_table[:user_id].not_in(recently_notified_users_ids)
  end

  def recently_notified_users_ids
    Notification.where(notification_query).distinct.pluck(:recipient_id)
  end

  def notification_query
    user_recipient.and(stale_notification_type).and(recently_created)
  end

  def user_recipient
    notifications_table[:recipient_type].eq("User")
  end

  def stale_notification_type
    notifications_table[:type].eq(Developers::ProfileReminderNotification.name)
  end

  def recently_created
    notifications_table[:created_at].gteq(EARLIEST_TIME)
  end

  def developers_table
    Developer.arel_table
  end

  def notifications_table
    Notification.arel_table
  end
end
