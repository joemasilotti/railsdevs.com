# Business (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(plan: "railsdevs")

# Lead business
SeedsHelper.create_business!("lead")
