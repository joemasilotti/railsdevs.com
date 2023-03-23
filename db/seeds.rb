require "seeds_helper"

def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

# Disable letter_opener opening emails in the browser.
ActiveJob::Base.queue_adapter = :inline
ActionMailer::Base.delivery_method = :test

# Disable developer response grace period to prevent scheduling future jobs.
Rails.configuration.developer_response_grace_period = nil

puts "Seeding #{Rails.env} database..."
seed "admins"
seed "developers"
seed "businesses"
seed "conversations"
seed "hiring"
seed "referrals"
seed "specialties"
puts "Seeded database"
