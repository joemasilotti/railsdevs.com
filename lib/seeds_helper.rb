module SeedsHelper
  class << self
    def create_developer!(name, attributes = {})
      user = create_user!(name)
      attributes.merge!({
        user:,
        name: Faker::Name.name,
        hero: attributes.delete(:hero) || Faker::Lorem.sentence,
        bio: Faker::Lorem.paragraph(sentence_count: 10),
        profile_updated_at: attributes.delete(:profile_updated_at) || 2.weeks.ago,
        created_at: attributes.delete(:created_at) || 2.weeks.ago
      })

      Developer.find_or_create_by!(user:) do |developer|
        developer.assign_attributes(attributes)
        attach_developer_avatar(developer)
        developer.save_and_notify
      end
    end

    def create_random_developer!
      create_developer!(Faker::Internet.username, {
        location: locations[:portland],
        search_status: :open
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
        attach_business_avatar(business)
        business.save_and_notify
      end
    end

    def create_message!(conversation:, sender:, body:, cold_message: false)
      Message.find_or_create_by!(conversation:, sender:, body:) do |message|
        message.save_and_notify(cold_message:)
      end
    end

    def create_referral!(referred_user:, referring_user:, code:)
      Referral.find_or_create_by!(referred_user:) do |referral|
        referral.referring_user = referring_user
        referral.code = code
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

    def attach_developer_avatar(record)
      attach_avatar(record, developer_avatar_urls)
    end

    def attach_business_avatar(record)
      attach_avatar(record, business_avatar_urls)
    end

    def attach_avatar(record, avatars)
      uri = URI.parse(avatars[record.class.count])
      file = uri.open
      record.avatar.attach(io: file, filename: "avatar.png")
    end

    def location_seeds
      @location_seeds ||= YAML.load_file(Rails.root.join("db", "seeds", "locations.yml"))
    end

    def developer_avatar_urls
      @developer_avatar_urls ||= YAML.load_file(Rails.root.join("db", "seeds", "avatars.yml"))
        .map { |image_id| unsplash_url_for(image_id) }
    end

    def business_avatar_urls
      @business_avatar_urls ||= YAML.load_file(Rails.root.join("db", "seeds", "business_avatars.yml"))
        .map { |image_id| unsplash_url_for(image_id) }
    end

    def unsplash_url_for(image_id)
      "https://images.unsplash.com/#{image_id}?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=512"
    end
  end
end
