Specialty.upsert_all(
  YAML.load_file(Rails.root.join("db", "seeds", "specialties.yml")),
  unique_by: :name
)

User.find_by(email: "developer@example.com").developer.specialties = Specialty.first(5)
User.find_by(email: "freelancer@example.com").developer.specialties = [Specialty.second, Specialty.third]
User.find_by(email: "junior@example.com").developer.specialties = [Specialty.fourth]
