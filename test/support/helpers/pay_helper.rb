module PayHelper
  extend ActiveSupport::Concern

  included do
    def stub_pay(user, plan_price_id: part_time_plan_price_id, pay_name: part_time_plan_name)
      checkout = Minitest::Mock.new
      checkout.expect(:url, "checkout.stripe.com")

      payment_processor = Minitest::Mock.new
      payment_processor.expect(:checkout, checkout) do |options|
        options[:mode] == "subscription" &&
          options[:line_items] == plan_price_id &&
          options.dig(:subscription_data, :metadata, :pay_name) == pay_name
      end

      user.stub(:payment_processor, payment_processor) do
        yield
      end

      checkout.verify
      payment_processor.verify
    end

    private

    def part_time_plan_price_id
      Rails.application.credentials.stripe[:price_ids][:part_time_plan]
    end

    def part_time_plan_name
      BusinessSubscription::PartTime.new.name
    end
  end
end
