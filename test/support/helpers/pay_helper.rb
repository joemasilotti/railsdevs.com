module PayHelper
  extend ActiveSupport::Concern

  included do
    def stub_pay(user, expected_success_url: conversations_url)
      checkout = Minitest::Mock.new
      checkout.expect(:url, "checkout.stripe.com")

      payment_processor = Minitest::Mock.new
      payment_processor.expect(:checkout, checkout, [{
        mode: "subscription",
        line_items: "price_FAKE_PRICE_ID_FOR_TESTS",
        success_url: expected_success_url
      }])

      user.stub(:payment_processor, payment_processor) do
        yield
      end

      checkout.verify
      payment_processor.verify
    end
  end
end
