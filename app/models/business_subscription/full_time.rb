module BusinessSubscription
  class FullTime
    def price_id
      Rails.application.credentials.stripe.dig(:price_ids, :full_time_plan)
    end
  end
end
