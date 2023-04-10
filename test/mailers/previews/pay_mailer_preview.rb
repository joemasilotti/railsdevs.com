class PayMailerPreview < ActionMailer::Preview
  def subscription_renewing
    PayMailer.with(
      pay_customer: Pay::Customer.first,
      pay_subscription: Pay::Subscription.first,
      date: 3.days.from_now
    ).subscription_renewing
  end
end
