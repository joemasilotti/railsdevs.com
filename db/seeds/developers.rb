# Random developers
RANDOM_DEVELOPERS = 20
if Developer.count < RANDOM_DEVELOPERS
  (RANDOM_DEVELOPERS - Developer.count).times do
    SeedsHelper.create_random_developer!
  end
end

# Minimum developer
SeedsHelper.create_developer!("minimum", {
  hero: "Minimum developer",
  location: SeedsHelper.locations[:new_york]
})

# Invisible developer
developer = SeedsHelper.create_developer!("invisible", {
  hero: "Invisible developer",
  location: SeedsHelper.locations[:new_york]
})
developer.invisiblize_and_notify! unless developer.invisible?

# Stale developer
developer = SeedsHelper.create_developer!("stale", {
  hero: "Stale developer",
  location: SeedsHelper.locations[:new_york]
})
long_time_ago = 31.days.ago
developer.update!(created_at: long_time_ago, updated_at: long_time_ago)
developer.notify_as_stale unless Notification.exists?(type: Developers::ProfileReminderNotification.name)

# Featured developer
developer = SeedsHelper.create_developer!("featured", {
  hero: "Featured developer",
  location: SeedsHelper.locations[:new_york]
})
developer.feature! unless developer.featured_at?

# Junior developer
SeedsHelper.create_developer!("junior", {
  hero: "Junior developer",
  location: SeedsHelper.locations[:new_york],
  search_status: :actively_looking,
  role_type: RoleType.new(full_time_employment: true),
  role_level: RoleLevel.new(junior: true),
  available_on: Date.yesterday
})

# Freelancer developer
SeedsHelper.create_developer!("freelancer", {
  hero: "Freelance developer",
  location: SeedsHelper.locations[:new_york],
  search_status: :open,
  role_type: RoleType.new(part_time_contract: true),
  role_level: RoleLevel.new(mid: true, senior: true),
  available_on: Date.today + 7.days,
  website: Faker::Internet.url,
  github: Faker::Internet.username
})

# Core developer
SeedsHelper.create_developer!("developer", {
  hero: "Core developer",
  location: SeedsHelper.locations[:new_york],
  search_status: :actively_looking,
  role_type: RoleType.new(RoleType::TYPES.map { |t| [t, true] }.to_h),
  role_level: RoleLevel.new(RoleLevel::TYPES.map { |t| [t, true] }.to_h),
  available_on: Date.yesterday,
  website: Faker::Internet.url,
  github: Faker::Internet.username,
  twitter: Faker::Internet.username,
  mastodon: Faker::Internet.url,
  linkedin: Faker::Internet.username,
  stack_overflow: Faker::Number.number(digits: 6)
})

# Potential hire
developer = SeedsHelper.create_developer!("hired", {
  hero: "Hired Developer",
  location: SeedsHelper.locations[:new_york],
  search_status: :actively_looking,
  role_type: RoleType.new(RoleType::TYPES.map { |t| [t, true] }.to_h),
  role_level: RoleLevel.new(RoleLevel::TYPES.map { |t| [t, true] }.to_h)
})
developer.update_and_notify(search_status: :not_interested) unless developer.not_interested?
