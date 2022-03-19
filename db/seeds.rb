require "seeds_helper"

def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

puts "Seeding #{Rails.env} database..."
seed "developers"
seed "businesses"
seed "admins"
seed "conversations"
puts "Seeded database"
