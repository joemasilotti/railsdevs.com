module RevenueCat
  class Sync
    private attr_reader :event

    def initialize(event)
      @connection = connection
      @event = event.with_indifferent_access
    end

    def sync_subscriptions
      body = connection.get(user.id.to_s).body.with_indifferent_access
      if (plan = body.dig(:subscriber, :subscriptions, :full_time_plan))
        user.set_payment_processor(:fake_processor, allow_fake: true)
        subscription = Businesses::Subscription.with_identifier(:full_time)
        user.payment_processor.subscribe(plan: subscription.price_id, ends_at: plan[:expires_date])
      end
    end

    private

    def user
      @user ||= User.find(event[:app_user_id])
    end

    def connection
      Faraday.new(
        url:,
        headers: {
          Authorization: "Bearer #{api_key}",
          "X-Platform": "ios"
        }
      ) do |f|
        f.request(:json)
        f.response(:json)
      end
    end

    def url
      "https://api.revenuecat.com/v1/subscribers"
    end

    def api_key
      Rails.application.credentials.revenue_cat.public_key
    end
  end
end
