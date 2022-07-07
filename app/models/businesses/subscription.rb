module Businesses
  class Subscription
    class UnknownSubscription < StandardError; end

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
        data = subscription_data[identifier]
        raise UnknownSubscription.new("Unknown identifier: #{identifier}") unless data.present?
        Subscription.new(**data)
      end

      def with_processor_plan(processor_plan)
        data = subscription_data.values.find do |data|
          [data[:stripe_price_id], data[:revenue_cat_product_identifier]].include?(processor_plan)
        end
        raise UnknownSubscription.new("Unknown processor plan: #{processor_plan}") unless data.present?
        Subscription.new(**data)
      end

      private

      def subscription_data
        Rails.configuration.subscriptions
      end
    end
  end
end
