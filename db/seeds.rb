require "seeds_helper"

def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

puts "Seeding database..."
seed("developers")
seed("businesses")
seed("conversations")
puts "Seeded database"
