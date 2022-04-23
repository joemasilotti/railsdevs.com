module BusinessSubscription
  class PartTime
    def price_id
      BusinessSubscription.price_ids[:part_time_plan]
    end
    alias_method :plan, :price_id

    def price
      99
    end
  end
end
