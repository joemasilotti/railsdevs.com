namespace :businesses do
  desc "Email current and past subscribers link to survey"
  task email_survey: :environment do
    businesses = Pay::Customer.includes(owner: :business)
      .where(id: Pay::Subscription.group(:customer_id).count.keys)
      .map { |c| c.owner.business }

    puts "Sending #{businesses.count} emails to current/past subscribers..."
    businesses.each do |business|
      BusinessMailer.with(business: business).survey.deliver_later
    end
  end

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
