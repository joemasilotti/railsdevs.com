module OpenStartup
  class Stripe
    class << self
      def balance_transactions
        transactions = ::Stripe::BalanceTransaction.list({limit: 100}, {api_key: reporting_api_key})
        result = []
        transactions.auto_paging_each do |transaction|
          result << transaction
        end
        result
      end

      def subscriptions
        subscriptions = ::Stripe::Subscription.list({limit: 100}, {api_key: reporting_api_key})
        result = []
        subscriptions.auto_paging_each do |subscription|
          result << subscription
        end
        result
      end

      private

      def reporting_api_key
        Rails.application.credentials.stripe[:reporting_key]
      end
    end
  end
end
