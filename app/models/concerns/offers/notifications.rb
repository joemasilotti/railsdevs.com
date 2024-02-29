module Offers
  module Notifications
    def save_and_notify
      if save
        send_developer_notification
        true
      end
    end

    def accept_and_notify
      if update(state: :accepted)
        send_offer_accepted_notification
        true
      end
    end

    def decline_and_notify
      if update(state: :declined)
        send_offer_declined_notification
        true
      end
    end

    private

    def send_developer_notification
      NewOfferNotification.with(offer: self, conversation:).deliver_later(receiver.user)
    end

    def send_offer_accepted_notification
      OfferAcceptedNotification.with(offer: self, conversation:).deliver_later(sender.user)
    end

    def send_offer_declined_notification
      OfferDeclinedNotification.with(offer: self, conversation:).deliver_later(sender.user)
    end
  end
end
