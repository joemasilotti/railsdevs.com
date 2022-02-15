module PayHelper
  extend ActiveSupport::Concern

  included do
    def stub_pay(user)
      checkout = Minitest::Mock.new
      checkout.expect(:url, "checkout.stripe.com")

      payment_processor = Minitest::Mock.new
      payment_processor.expect(:checkout, checkout) do |options|
        options[:mode] == "subscription" && options[:line_items] == "price_FAKE_PRICE_ID_FOR_TESTS"
      end

      user.stub(:payment_processor, payment_processor) do
        yield
      end

      checkout.verify
      payment_processor.verify
    end
  end
end
