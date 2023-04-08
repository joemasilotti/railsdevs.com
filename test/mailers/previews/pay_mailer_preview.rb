class PayMailerPreview < ActionMailer::Preview
  def subscription_renewing
    customer = Pay::Customer.first
    renewal_date = 3.days.from_now
    PayMailer.with(pay_customer: customer, date: renewal_date).subscription_renewing
  end
end
