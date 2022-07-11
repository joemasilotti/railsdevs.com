module Businesses
  class Plan
    class UnknownPlan < StandardError; end

    attr_reader :name, :price, :stripe_price_id, :revenue_cat_product_identifier

    def initialize(name:, price:, stripe_price_id:, revenue_cat_product_identifier:)
      @name = name
      @price = price
      @stripe_price_id = stripe_price_id
      @revenue_cat_product_identifier = revenue_cat_product_identifier
    end

    def processor_plans
      [stripe_price_id, revenue_cat_product_identifier]
    end

    class << self
      def with_identifier(identifier)
        identifier = identifier.to_s.to_sym
        data = plan_data[identifier]
        raise UnknownPlan.new("Unknown identifier: #{identifier}") unless data.present?
        Plan.new(**data)
      end

      def with_processor_plan(processor_plan)
        data = plan_data.values.find do |data|
          [data[:stripe_price_id], data[:revenue_cat_product_identifier]].include?(processor_plan)
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
