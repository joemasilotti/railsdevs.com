developer = User.find_by(email: "developer@example.com").developer

Hired::Form.find_or_create_by!(developer:) do |form|
  form.address = "123 Main St\nNew York, NY 10001"
  form.company = "Rails for All"
  form.position = "Rails Developer"
  form.start_date = Date.today
  form.employment_type = :full_time
  form.feedback = "Keep up the great work with RailsDevs!"
end
