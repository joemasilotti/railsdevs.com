if Rails.env.production?
  raise "You're in Production! Seeding data is prohibited!"
end

DEFAULT_PASSWORD = "password"

def colorize(text, code:)
  "\e[#{code}m#{text}\e[0m"
end

if ENV["TRUNCATE_ALL"] == "yes"
  puts "Truncating all data..."
  system("bin/rails db:truncate_all")
end

def create_user!(name)
  User.create!(
    email: "#{name}@example.com",
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD,
    confirmed_at: DateTime.current
  )
end

def attach(filename, to:)
  to.attach(io: File.open(Rails.root.join("test/fixtures/files", filename)), filename:)
end

def create_developer!(attributes)
  avatar_name = attributes.delete(:avatar_name)
  Developer.create!(attributes) do |developer|
    attach(avatar_name, to: developer.avatar)
  end
end

puts "Starting to seed data..."
ApplicationRecord.transaction requires_new: true do
  time_zones = ["Eastern Time (US & Canada)", "Pacific Time (US & Canada)"]
  developer = nil
  puts " Creating developers..."
  10.times do |num|
    name_num = num > 0 ? num : ""
    dev = create_developer!(
      user: create_user!("Dennis#{name_num}"),
      name: "Dennis#{name_num} Ritchie",
      available_on: Date.new(2021, 1, 1),
      hero: "Creator of C",
      bio: "An American computer scientist. Created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system and B programming language.",
      website: [nil, "https://example.com/dennis#{name_num}"].sample,
      github: [nil, "dennis#{name_num}"].sample,
      twitter: [nil, "ritchie#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar_name: "dennis.png",
      role_type: RoleType.new(part_time_contract: true, full_time_contract: true)
    )
    developer ||= dev

    create_developer!(
      user: create_user!("Bjarne#{name_num}"),
      name: "Bjarne#{name_num} Stroustrup",
      available_on: Date.new(2022, 1, 1),
      hero: "Creator of C++",
      bio: "A Danish computer scientist, most notable for the creation and development of the C++ programming language. A visiting professor at Columbia University, and works at Morgan Stanley as a Managing Director in New York.",
      website: [nil, "https://example.com/bjarne#{name_num}"].sample,
      github: [nil, "bjarne#{name_num}"].sample,
      twitter: [nil, "stroustrup#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar_name: "bjarne.png",
      role_type: RoleType.new(full_time_employment: true)
    )

    create_developer!(
      user: create_user!("Ada#{name_num}"),
      name: "Ada#{name_num} Lovelace",
      available_on: Date.new(2021, 1, 1),
      hero: "First computer programmer",
      bio: "An English mathematician and writer, chiefly known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine.",
      website: [nil, "https://example.com/ada#{name_num}"].sample,
      github: [nil, "ada#{name_num}"].sample,
      twitter: [nil, "lovelace#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar_name: "lovelace.jpg"
    )
  end

  puts " Creating admin..."
  admin = create_user!("admin")
  admin.update!(admin: true)

  puts " Creating business..."
  business = Business.new(
    user: create_user!("Business"),
    name: "Thomas Dohmke",
    company: "GitHub",
    bio: "GitHub is where over 73 million developers shape the future of software, together.",
    developer_notifications: :no
  )
  attach("mountains.jpg", to: business.avatar)

  business.user.set_payment_processor(:fake_processor, allow_fake: true)
  business.user.payment_processor.subscribe(plan: "railsdevs")

  puts " Creating conversation..."
  conversation = Conversation.create!(developer:, business:)
  Message.create!(conversation:, sender: business, body: "Let's work together, Dennis!")

  puts colorize("Seeding data success!", code: 32)

  puts "You may use the following credentials to sign in:"

  puts colorize("1) Admin: #{admin.email}, #{DEFAULT_PASSWORD}", code: 33)

  [developer, business].each_with_index do |account, idx|
    text = "#{idx + 2}) #{account.class.name}: "\
           "#{account.user.email}, #{DEFAULT_PASSWORD}"
    puts colorize(text, code: 33)
  end

rescue => error
  puts colorize("Seeding data fail!", code: 31)
  puts colorize(error.message, code: 31)
  puts error.backtrace.first(20).join("\n")

  raise ActiveRecord::Rollback
end
