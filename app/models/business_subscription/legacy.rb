module BusinessSubscription
  class Legacy
    def price_id
      BusinessSubscription.price_ids[:legacy_plan]
    end
    alias_method :plan, :price_id

    def price
      99
    end

    def name
      "Legacy"
    end
  end
end
