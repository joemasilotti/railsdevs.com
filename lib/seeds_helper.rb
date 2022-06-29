module SeedsHelper
  AVATAR_URLS = [
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHwxfHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHwyfHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1599566150163-29194dcaad36?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHwzfHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw0fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw1fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1527980965255-d3b416303d12?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw2fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1580489944761-15a19d654956?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw3fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1633332755192-727a05c4013d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw4fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1607746882042-944635dfe10e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHw5fHxhdmF0YXJ8ZW58MHx8fHwxNjU2NTM2NDYw&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit",
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNDIyNzJ8MHwxfHNlYXJjaHwxMHx8YXZhdGFyfGVufDB8fHx8MTY1NjUzNjQ2MA&ixlib=rb-1.2.1&q=80&w=1080&utm_source=api_app&utm_medium=referral&utm_campaign=api-credit"
  ].freeze

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
        attach_avatar(developer)
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
        attach_avatar(business)
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

    def attach_avatar(record)
      uri = URI.parse(AVATAR_URLS.sample)
      file = uri.open
      record.avatar.attach(io: file, filename: "avatar.png")
    end

    def location_seeds
      @location_seeds ||= YAML.load_file(File.join(Rails.root, "db", "seeds", "locations.yml"))
    end
  end
end
