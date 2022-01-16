if Rails.env.production?
  raise "You're in Production! Seeding data is prohibited!"
end

def create_user!(name)
  User.transaction do
    User.create!(
      email: "#{name}@example.com",
      password: "password",
      password_confirmation: "password",
      confirmed_at: DateTime.current
    )
  rescue
    raise ActiveRecord::Rollback
  end
end

ApplicationRecord.transaction requires_new: true do
  time_zones = ["Eastern Time (US & Canada)", "Pacific Time (US & Canada)"]
  avatars = [
    ActiveStorage::Blob.create_and_upload!(io: File.open("test/fixtures/files/ritchie.jpg"), filename: "ritchie.jpg"),
    ActiveStorage::Blob.create_and_upload!(io: File.open("test/fixtures/files/stroustrup.jpg"), filename: "stroustrup.jpg"),
    ActiveStorage::Blob.create_and_upload!(io: File.open("test/fixtures/files/lovelace.jpg"), filename: "lovelace.jpg")
  ]
  developer = nil
  10.times do |num|
    name_num = num > 0 ? num : ""
    dev = Developer.create!(
      user: create_user!("Dennis#{name_num}"),
      name: "Dennis#{name_num} Ritchie",
      available_on: Date.new(2021, 1, 1),
      hero: "Creator of C",
      bio: "An American computer scientist. Created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system and B programming language.",
      website: [nil, "https://example.com/dennis#{name_num}"].sample,
      github: [nil, "dennis#{name_num}"].sample,
      twitter: [nil, "ritchie#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar: avatars.sample,
      role_type: RoleType.new(part_time_contract: true, full_time_contract: true)
    )
    developer ||= dev

    Developer.create!(
      user: create_user!("Bjarne#{name_num}"),
      name: "Bjarne#{name_num} Stroustrup",
      available_on: Date.new(2022, 1, 1),
      hero: "Creator of C++",
      bio: "A Danish computer scientist, most notable for the creation and development of the C++ programming language. A visiting professor at Columbia University, and works at Morgan Stanley as a Managing Director in New York.",
      website: [nil, "https://example.com/bjarne#{name_num}"].sample,
      github: [nil, "bjarne#{name_num}"].sample,
      twitter: [nil, "stroustrup#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar: avatars.sample,
      role_type: RoleType.new(full_time_employment: true)
    )

    Developer.create!(
      user: create_user!("Ada#{name_num}"),
      name: "Ada#{name_num} Lovelace",
      available_on: Date.new(2021, 1, 1),
      hero: "First computer programmer",
      bio: "An English mathematician and writer, chiefly known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine.",
      website: [nil, "https://example.com/ada#{name_num}"].sample,
      github: [nil, "ada#{name_num}"].sample,
      twitter: [nil, "lovelace#{name_num}"].sample,
      time_zone: time_zones.sample,
      avatar: avatars.sample
    )
  end

  admin = create_user!("admin")
  admin.update!(admin: true)

  business = Business.create!(
    user: create_user!("Business"),
    name: "Thomas Dohmke",
    company: "GitHub",
    bio: "GitHub is where over 73 million developers shape the future of software, together.",
    developer_notifications: :no,
    avatar: ActiveStorage::Blob.create_and_upload!(io: File.open("test/fixtures/files/basecamp.png"), filename: "basecamp.png")
  )

  business.user.set_payment_processor(:fake_processor, allow_fake: true)
  business.user.payment_processor.subscribe(plan: "railsdevs")

  conversation = Conversation.create!(developer:, business:)
  Message.create!(conversation:, sender: business, body: "Let's work together, Dennis!")

  puts "Seeding data success!"

rescue => error
  puts "Seeding data fail!"
  puts error.message
  puts error.backtrace.first(20).join("\n")

  raise ActiveRecord::Rollback
end
