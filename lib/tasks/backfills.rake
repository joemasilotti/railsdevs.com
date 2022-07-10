require "seeds_helper"

desc "These tasks are meant to be run once then removed"
namespace :backfills do
  desc "Create and confirm two demo accounts for App Store review"
  task demo_accounts: :environment do
    User.transaction do
      # Create demo developer.
      developer_password = SecureRandom.hex(10)
      user = User.create!(
        email: "demo-developer@example.com",
        password: developer_password,
        confirmed_at: Time.current
      )
      developer = Developer.new(
        user:,
        demo: true,
        hero: "Demo Developer",
        name: "Demo Developer",
        bio: "Don't message me, I'm a demo account for App Store review!",
        search_status: :invisible,
        location: SeedsHelper.locations[:new_york]
      )
      SeedsHelper.attach_avatar(developer, name: "Demo Developer")
      developer.save!

      # Create demo business.
      business_password = SecureRandom.hex(10)
      user = User.create!(
        email: "demo-business@example.com",
        password: business_password,
        confirmed_at: Time.current
      )
      business = Business.new(
        user:,
        name: "Demo Business",
        company: "Demo Business",
        bio: "I won't message you, I'm a demo account for App Store review!"
      )
      SeedsHelper.attach_avatar(business, name: "Demo Business")
      business.save!

      plan = Businesses::Plan.with_identifier(:demo)
      business.user.set_payment_processor(:fake_processor, allow_fake: true)
      business.user.payment_processor.subscribe(plan: plan.stripe_price_id)

      # Print passwords to share with App Store review team.
      puts "Developer password: #{developer_password}"
      puts "Business password: #{business_password}"
    end
  end
end
