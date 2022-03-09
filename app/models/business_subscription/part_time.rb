module BusinessSubscription
  class PartTime
    def price_id
      Rails.application.credentials.stripe.dig(:price_ids, :part_time_plan)
    end
  end
end
