desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task sync_stripe_subscriptions: :environment do
    Pay::Subscription.stripe.find_each.map(&:sync!)
  end
end
