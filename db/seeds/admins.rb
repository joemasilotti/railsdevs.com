User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  confirmed_at: DateTime.current,
  admin: true
)
