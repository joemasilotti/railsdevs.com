# Business on full-time plan (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(name: BusinessSubscription::FullTime.new.name)

# Business on part-time plan (part-time)
business = SeedsHelper.create_business!("part-time")
business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(name: BusinessSubscription::PartTime.new.name)

# Lead business (lead)
SeedsHelper.create_business!("lead")
