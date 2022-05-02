module SeedsHelper
  class << self
    def create_developer!(name, attributes = {})
      user = create_user!(name)
      attributes.merge!({
        user:,
        name: Faker::Name.name,
        hero: attributes.delete(:hero) || Faker::Lorem.sentence,
        bio: Faker::Lorem.paragraph(sentence_count: 10)
      })

      Developer.find_or_create_by!(user:) do |developer|
        developer.assign_attributes(attributes)
        attach_avatar(developer, name: developer.hero)
      end
    end

    def create_random_developer!
      create_developer!(Faker::Internet.username, {
        location: locations[:portland],
        search_status: :open,
        available_on: Faker::Date.between(from: 30.days.ago, to: 30.days.from_now)
      })
    end

    def create_business!(name, attributes = {})
      company = "#{name.titleize} Company"
      attributes.merge!({
        user: create_user!(name),
        contact_name: Faker::Name.name,
        company:,
        bio: Faker::Lorem.paragraph(sentence_count: 10)
      })

      Business.find_or_create_by!(company:) do |business|
        business.assign_attributes(attributes)
        attach_avatar(business, name: business.company)
      end
    end

    def locations
      location_seeds.map do |name, attrs|
        [name.to_sym, Location.new(attrs)]
      end.to_h
    end

    private

    def create_user!(name)
      email = "#{name}@example.com"
      attributes = {
        email:,
        password: "password",
        password_confirmation: "password",
        confirmed_at: DateTime.current
      }

      User.find_or_create_by!(email:) do |user|
        user.assign_attributes(attributes)
      end
    end

    def attach_avatar(record, name:)
      url = "https://ui-avatars.com/api/?size=300&background=random&name=#{name.parameterize}"
      uri = URI.parse(url)
      file = uri.open
      record.avatar.attach(io: file, filename: "avatar.png")
    end

    def location_seeds
      @location_seeds ||= YAML.load_file(File.join(Rails.root, "db", "seeds", "locations.yml"))
    end
  end
end
