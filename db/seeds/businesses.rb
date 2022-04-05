# Business (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
business.account.owner.set_payment_processor(:fake_processor, allow_fake: true)
business.account.owner.payment_processor.subscribe(name: BusinessSubscription::FullTime.new.name)

# Lead business
SeedsHelper.create_business!("lead")
