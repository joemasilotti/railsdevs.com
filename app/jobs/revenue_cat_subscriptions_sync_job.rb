class RevenueCatSubscriptionsSyncJob < ApplicationJob
  queue_as :default

  def perform(*args)
    RevenueCat::Sync.new(args.first).sync_subscriptions
  end
end
