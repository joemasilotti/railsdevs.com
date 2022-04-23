# Business on full-time plan (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(plan: BusinessSubscription::FullTime.new.plan)

# Business on part-time plan (part-time)
business = SeedsHelper.create_business!("part-time")
business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(plan: BusinessSubscription::PartTime.new.plan)

# Lead business (lead)
SeedsHelper.create_business!("lead")
