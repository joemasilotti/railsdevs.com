# Business on full-time plan (business)
business = SeedsHelper.create_business!("business", {
  developer_notifications: :daily
})
SeedsHelper.subscribe_user_to_plan(business.user, plan_identifier: :full_time)

# Business on part-time plan (part-time)
business = SeedsHelper.create_business!("part-time")
SeedsHelper.subscribe_user_to_plan(business.user, plan_identifier: :part_time)

# Lead business (lead)
SeedsHelper.create_business!("lead")

# Invisible business
SeedsHelper.create_business!("invisible", {invisible: true})
