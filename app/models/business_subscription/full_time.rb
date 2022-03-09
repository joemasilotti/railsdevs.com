module BusinessSubscription
  class FullTime
    def price_id
      BusinessSubscription.price_ids[:full_time_plan]
    end
  end
end
