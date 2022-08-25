module Pay
  module SubscriptionExtensions
    extend ActiveSupport::Concern

    included do
      after_commit :send_admin_notification
    end

    def send_admin_notification
      Admin::SubscriptionChangeNotification.new(
        subscription: self,
        change: SubscriptionChanges.new(self).change
      ).deliver_later(User.admin)
    rescue Pay::SubscriptionChanges::UnknownSubscriptionChange => e
      Honeybadger.notify(e)
    end
  end
end
