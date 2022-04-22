email = "admin@example.com"
attributes = {
  email:,
  password: "password",
  password_confirmation: "password",
  confirmed_at: DateTime.current,
  admin: true
}

User.find_or_create_by!(email:) do |user|
  user.assign_attributes(attributes)
end
