module SeedsHelper
  class << self
    def create_developer!(name, attributes = {})
      attributes.merge!({
        user: create_user!(name),
        name: Faker::Name.name,
        hero: attributes.delete(:hero) || Faker::Lorem.sentence,
        bio: Faker::Lorem.paragraph(sentence_count: 10)
      })
      Developer.create!(attributes) do |developer|
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
      attributes.merge!({
        user: create_user!(name),
        name: Faker::Name.name,
        company: Faker::Company.name,
        bio: Faker::Lorem.paragraph(sentence_count: 10)
      })
      Business.create!(attributes) do |business|
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
      User.create!(
        email: "#{name}@example.com",
        password: "password",
        password_confirmation: "password",
        confirmed_at: DateTime.current
      )
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
