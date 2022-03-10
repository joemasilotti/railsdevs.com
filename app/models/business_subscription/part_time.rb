module BusinessSubscription
  class PartTime
    def name
      "part_time"
    end

    def price_id
      BusinessSubscription.price_ids[:part_time_plan]
    end
  end
end
