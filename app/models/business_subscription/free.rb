module BusinessSubscription
  class Free
    def price_id
      nil
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
