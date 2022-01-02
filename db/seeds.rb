def create_user!(name)
  User.create!(
    email: "#{name}@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: DateTime.current
  )
end

admin = create_user!("admin")
admin.update!(admin: true)

developer = Developer.create!(
  user: create_user!("Dennis"),
  name: "Dennis Ritchie",
  available_on: Date.new(2021, 1, 1),
  hero: "Creator of C",
  bio: "An American computer scientist. Created the C programming language and, with long-time colleague Ken Thompson, the Unix operating system and B programming language.",
  website: "https://example.com/dennis",
  github: "dennis",
  twitter: "ritchie"
)

Developer.create!(
  user: create_user!("Bjarne"),
  name: "Bjarne Stroustrup",
  available_on: Date.new(2022, 1, 1),
  hero: "Creator of C++",
  bio: "A Danish computer scientist, most notable for the creation and development of the C++ programming language. A visiting professor at Columbia University, and works at Morgan Stanley as a Managing Director in New York.",
  website: "https://example.com/bjarne",
  github: "bjarne",
  twitter: "stroustrup"
)

Developer.create!(
  user: create_user!("Ada"),
  name: "Ada Lovelace",
  available_on: Date.new(2021, 1, 1),
  hero: "First computer programmer",
  bio: "An English mathematician and writer, chiefly known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine.",
  website: "https://example.com/ada",
  github: "ada",
  twitter: "lovelace"
)

business = Business.create!(
  user: create_user!("Business"),
  name: "Thomas Dohmke",
  company: "GitHub",
  bio: "GitHub is where over 73 million developers shape the future of software, together."
)

business.user.set_payment_processor(:fake_processor, allow_fake: true)
business.user.payment_processor.subscribe(plan: "railsdevs")

conversation = Conversation.create!(developer: developer, business: business)
Message.create!(conversation: conversation, sender: business, body: "Let's work together, Dennis!")
