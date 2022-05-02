module Developers
  module Notifications
    def save_and_notify
      if save
        send_admin_notification
        send_welcome_email
        true
      end
    end

    def update_and_notify(attributes)
      if update(attributes)
        notify_admins_of_potential_hire if changes_indicate_potential_hire?
        true
      end
    end

    def invisiblize_and_notify!
      invisible!
      send_invisiblize_notification
    end

    private

    AVAILABLE_STATUSES = %w[actively_looking open].freeze
    UNAVAILABLE_STATUSES = %w[not_interested invisible].freeze

    def changes_indicate_potential_hire?
      return false unless saved_change_to_search_status?

      original_value, saved_value = saved_change_to_search_status
      AVAILABLE_STATUSES.include?(original_value) && UNAVAILABLE_STATUSES.include?(saved_value)
    end

    def send_admin_notification
      NewDeveloperProfileNotification.with(developer: self).deliver_later(User.admin)
    end

    def send_welcome_email
      DeveloperMailer.with(developer: self).welcome_email.deliver_later
    end

    def notify_admins_of_potential_hire
      PotentialHireNotification.with(developer: self).deliver_later(User.admin)
    end

    def send_invisiblize_notification
      InvisiblizeDeveloperNotification.with(developer: self).deliver_later(user)
    end
  end
end
