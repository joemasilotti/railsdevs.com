module Offers
  module Notifications
    def save_and_notify
      if save
        send_developer_notification
        true
      end
    end

    private

    def send_developer_notification
      NewOfferNotification.with(offer: self, conversation:).deliver_later(developer.user)
    end
  end
end
