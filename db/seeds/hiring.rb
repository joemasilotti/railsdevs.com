developer = User.find_by(email: "developer@example.com").developer
business = User.find_by(email: "business@example.com").business

Hired::Form.find_or_create_by!(developer:) do |form|
  form.address = "123 Main St\nNew York, NY 10001"
  form.company = "Rails for All"
  form.position = "Rails Developer"
  form.start_date = Date.today
  form.employment_type = :full_time_employment
  form.feedback = "Keep up the great work with RailsDevs!"
  form.save_and_notify
end

Businesses::HiringInvoiceRequest.find_or_create_by!(business:) do |form|
  form.billing_address = "123 Main St\nNew York, NY 10001"
  form.developer_name = "John Doe"
  form.position = "Rails Developer"
  form.start_date = Date.today
  form.annual_salary = 80_000
  form.employment_type = :full_time_employment
  form.feedback = "John is the perfect candidate!"
  form.save_and_notify
end

HiringAgreements::Term.first_or_create! do |term|
  term.body = "Example hiring terms for RailsDevs. Make sure to follow them!"
  term.active = true
end
