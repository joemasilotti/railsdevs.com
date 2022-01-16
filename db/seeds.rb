def create_user!(name)
  User.create!(
    email: "#{name}@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: DateTime.current
  )
end

def create_developer!(attributes, avatar_name:)
  developer = Developer.new(attributes)
  developer.avatar.attach(io: File.open(Rails.root.join("test/files/#{avatar_name}")), filename: avatar_name)
  developer.save!

  developer
end

admin = create_user!("admin")
admin.update!(admin: true)

developer = create_developer!(
  {
    user: create_user!("Dennis"),
    name: "Dennis Ritchie",
    available_on: Date.new(2021, 1, 1),
    hero: "Creator of C",
    bio: "An American computer scientist. Created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system and B programming language.",
    website: "https://example.com/dennis",
    github: "dennis",
    twitter: "ritchie",
    time_zone: "Eastern Time (US & Canada)"
  },
  avatar_name: "dennis.png"
)

create_developer!(
  {
    user: create_user!("Bjarne"),
    name: "Bjarne Stroustrup",
    available_on: Date.new(2022, 1, 1),
    hero: "Creator of C++",
    bio: "A Danish computer scientist, most notable for the creation and development of the C++ programming language. A visiting professor at Columbia University, and works at Morgan Stanley as a Managing Director in New York.",
    website: "https://example.com/bjarne",
    github: "bjarne",
    twitter: "stroustrup",
    time_zone: "Eastern Time (US & Canada)"
  },
  avatar_name: "bjarne.png"
)

create_developer!(
  {
    user: create_user!("Ada"),
    name: "Ada Lovelace",
    available_on: Date.new(2021, 1, 1),
    hero: "First computer programmer",
    bio: "An English mathematician and writer, chiefly known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine.",
    website: "https://example.com/ada",
    github: "ada",
    twitter: "lovelace",
    time_zone: "Eastern Time (US & Canada)"
  },
  avatar_name: "ada.png"
)

business = Business.new(
  user: create_user!("Business"),
  name: "Thomas Dohmke",
  company: "GitHub",
  bio: "GitHub is where over 73 million developers shape the future of software, together.",
  developer_notifications: :no
)
business.avatar.attach(io: File.open(Rails.root.join("test/files/business.png")), filename: "business.png")
business.save!

business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(plan: "railsdevs")

conversation = Conversation.create!(developer:, business:)
Message.create!(conversation:, sender: business, body: "Let's work together, Dennis!")
