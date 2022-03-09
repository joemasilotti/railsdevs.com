module BusinessSubscription
  class PartTime
    def price_id
      BusinessSubscription.price_ids[:part_time_plan]
    end
  end
end
