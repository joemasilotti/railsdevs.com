module BusinessSubscription
  class Free
    def price_id
      "Business subscription"
    end
    alias_method :plan, :price_id

    def price
      0
    end

    def name
      "Free"
    end
  end
end
