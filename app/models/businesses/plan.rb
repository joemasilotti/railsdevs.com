module Businesses
  class Plan
    class UnknownPlan < StandardError; end

    Timeframe = Struct.new(:monthly, :annual, keyword_init: true)

    attr_reader :name, :revenue_cat_product_identifier

    def initialize(name:, revenue_cat_product_identifier:, price: nil, prices: nil, stripe_price_id: nil, stripe_price_ids: nil)
      @name = name
      @price = price
      @prices = prices
      @stripe_price_id = stripe_price_id
      @stripe_price_ids = stripe_price_ids
      @revenue_cat_product_identifier = revenue_cat_product_identifier
    end

    def price
      prices.monthly
    end

    def prices
      if @price.present?
        Timeframe.new(monthly: @price, annual: nil)
      else
        Timeframe.new(@prices)
      end
    end

    def stripe_price_id
      stripe_price_ids.monthly
    end

    def stripe_price_ids
      if @stripe_price_id.present?
        Timeframe.new(monthly: @stripe_price_id, annual: nil)
      else
        Timeframe.new(@stripe_price_ids)
      end
    end

    def processor_plans
      [stripe_price_ids.monthly, stripe_price_ids.annual, revenue_cat_product_identifier].compact
    end

    class << self
      def with_identifier(identifier)
        identifier = identifier.to_s.to_sym
        data = plan_data[identifier]
        raise UnknownPlan.new("Unknown identifier: #{identifier}") unless data.present?
        Plan.new(**data)
      end

      # TODO: Hydrate models before doing searching to remove duplicate logic?
      def with_processor_plan(processor_plan)
        data = plan_data.values.find do |data|
          [data[:stripe_price_id], data[:revenue_cat_product_identifier]].include?(processor_plan) ||
            data[:stripe_price_ids]&.values&.include?(processor_plan)
        end
        raise UnknownPlan.new("Unknown processor plan: #{processor_plan}") unless data.present?
        Plan.new(**data)
      end

      private

      def plan_data
        Rails.configuration.plans
      end
    end
  end
end
