module Businesses
  class Subscription
    class UnknownSubscription < StandardError; end

    attr_reader :name, :price, :price_id

    def initialize(name:, price:, price_id:)
      @name = name
      @price = price
      @price_id = price_id
    end

    class << self
      def with_identifier(identifier)
        identifier = identifier.to_s.to_sym
        data = subscription_data[identifier]
        raise UnknownSubscription.new("Unknown identifier: #{identifier}") unless data.present?
        Subscription.new(**data)
      end

      def with_price_id(price_id)
        data = subscription_data.values.find do |data|
          data[:price_id] == price_id
        end
        raise UnknownSubscription.new("Unknown price ID: #{price_id}") unless data.present?
        Subscription.new(**data)
      end

      private

      def subscription_data
        Rails.configuration.subscriptions
      end
    end
  end
end
