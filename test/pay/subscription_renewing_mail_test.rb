require "test_helper"

class SubscriptionRenewingMailTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "monthly subscription should receive correct renewal email" do
    subscription = pay_subscriptions(:full_time)
    event = new_upcoming_invoice_event(subscription)

    assert_emails 1 do
      Pay::Stripe::Webhooks::SubscriptionRenewing.new.call(event)
      perform_enqueued_jobs
    end

    last_mail = ActionMailer::Base.deliveries.last
    assert_equal [subscription.customer.owner.email], last_mail.to
    assert_equal "Your RailsDevs subscription renews soon. Have you made a hire?", last_mail.subject
  end

  private

  def new_upcoming_invoice_event(subscription)
    # Fixture from: https://github.com/pay-rails/pay/blob/master/test/support/fixtures/stripe/invoice.upcoming.json
    event_data = JSON.parse(File.read(file_fixture("pay/invoice.upcoming.json")))
    event = Stripe::Event.construct_from({data: event_data})
    event.data.object.lines.data.first.price.recurring.interval = "month"
    event.data.object.subscription = subscription.processor_id
    event
  end
end
