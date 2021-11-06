def create_user!(name)
  User.create!(
    email: "#{name}@example.com",
    password: "password",
    password_confirmation: "password",
    confirmed_at: DateTime.current
  )
end

Developer.create!(
  user: create_user!("Dennis"),
  name: "Dennis Ritchie",
  email: "dennis@example.com",
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
  email: "bjarne@example.com",
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
  email: "ada@example.com",
  available_on: Date.new(2021, 1, 1),
  hero: "First computer programmer",
  bio: "An English mathematician and writer, chiefly known for her work on Charles Babbage's proposed mechanical general-purpose computer, the Analytical Engine.",
  website: "https://example.com/ada",
  github: "ada",
  twitter: "lovelace"
)
