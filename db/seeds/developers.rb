# Random developers
20.times { SeedsHelper.create_random_developer! }

# Minimum developer
SeedsHelper.create_developer!("minimum", {
  hero: "Minimum developer",
  location: SeedsHelper.locations[:new_york]
})

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
  linkedin: Faker::Internet.username
})
