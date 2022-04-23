module BusinessSubscription
  class FullTime
    def price_id
      BusinessSubscription.price_ids[:full_time_plan]
    end
    alias_method :plan, :price_id

    def price
      299
    end

    def name
      "Full-time"
    end
  end
end
