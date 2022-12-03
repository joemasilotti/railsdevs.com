namespace :sync do
  desc "Sync Stripe Subscriptions"
  task subscriptions: :environment do
    Pay::Subscription.stripe.find_each.map(&:sync!)
  end
end
