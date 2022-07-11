module PayHelper
  extend ActiveSupport::Concern

  included do
    def stub_pay(user, plan_price_id: part_time_plan_price_id)
      checkout = Minitest::Mock.new
      checkout.expect(:url, "checkout.stripe.com")

      payment_processor = Minitest::Mock.new
      payment_processor.expect(:checkout, checkout) do |options|
        options[:mode] == "subscription" &&
          options[:line_items] == plan_price_id
      end

      user.stub(:payment_processor, payment_processor) do
        yield
      end

      checkout.verify
      payment_processor.verify
    end

    private

    def part_time_plan_price_id
      Businesses::Plan.with_identifier(:part_time).stripe_price_id
    end
  end
end
