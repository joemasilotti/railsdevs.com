# Business on full-time plan (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
if business.user.subscriptions.none?
  business.user.set_payment_processor(:fake_processor, allow_fake: true)
  business.user.payment_processor
    .subscribe(plan: Businesses::Plan.with_identifier(:full_time).stripe_price_id)
end

# Business on part-time plan (part-time)
business = SeedsHelper.create_business!("part-time")
if business.user.subscriptions.none?
  business.user.set_payment_processor(:fake_processor, allow_fake: true)
  business.user.payment_processor
    .subscribe(plan: Businesses::Plan.with_identifier(:part_time).stripe_price_id)
end

# Lead business (lead)
SeedsHelper.create_business!("lead")

# Invisible business
business = SeedsHelper.create_business!("invisible")
business.invisiblize_and_notify! if business.visible?

# Suspended business
business = SeedsHelper.create_business!("suspended")
business.user.update!(suspended: true) unless business.user.suspended?
