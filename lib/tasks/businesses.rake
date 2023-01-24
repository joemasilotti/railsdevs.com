namespace :businesses do
  desc "Email past and current subscribers new terms"
  task email_new_terms: :environment do
    price_ids = [
      Businesses::Plan.with_identifier(:full_time).stripe_price_id,
      Businesses::Plan.with_identifier(:part_time).stripe_price_id
    ]

    customers = Pay::Customer.joins(:subscriptions)
      .where(pay_subscriptions: {processor_plan: price_ids})

    customers.includes(owner: :business).find_each do |customer|
      BusinessMailer.with(business: customer.owner.business).new_terms.deliver_later
    end
  end
end
