module BusinessSubscription
  class Legacy
    def name
      "legacy"
    end

    def price_id
      BusinessSubscription.price_ids[:legacy_plan]
    end
  end
end
