desc "These tasks are meant to be run once then removed"
namespace :backfills do
  task subscription_plan_names: :environment do
    Pay::Subscription.where(name: "railsdevs").find_each do |subscription|
      subscription.name = BusinessSubscription::Legacy.new.name
      subscription.save!
    end
  end
end
