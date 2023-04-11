require "test_helper"

class SubscriptionRenewingMailTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "monthly subscription should receive correct renewal email" do
    renewal_timestamp = 3.days.from_now.to_i
    subscription = pay_subscriptions(:full_time)
    event = new_upcoming_invoice_event(subscription, renewal_timestamp)

    assert_enqueued_email_with PayMailer, :subscription_renewing, args: {
      pay_customer: subscription.customer,
      pay_subscription: subscription,
      date: Time.zone.at(renewal_timestamp)
    } do
      Pay::Stripe::Webhooks::SubscriptionRenewing.new.call(event)
    end
  end

  private

  def new_upcoming_invoice_event(subscription, renewal_timestamp)
    # Fixture from: https://github.com/pay-rails/pay/blob/master/test/support/fixtures/stripe/invoice.upcoming.json
    event_data = JSON.parse(File.read(file_fixture("pay/invoice.upcoming.json")))
    event = Stripe::Event.construct_from({data: event_data})
    event.data.object.lines.data.first.price.recurring.interval = "month"
    event.data.object.subscription = subscription.processor_id
    event.data.object.next_payment_attempt = renewal_timestamp
    event
  end
end
