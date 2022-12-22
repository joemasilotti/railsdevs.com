require "seeds_helper"

module Developers
  class PaywalledDeveloper
    attr_reader :hero, :bio, :avatar_url

    def initialize(hero:, bio:, avatar_url:)
      @hero = hero
      @bio = bio
      @avatar_url = avatar_url
    end

    class << self
      def generate(num = 1)
        generated_devs = []
        num.times do
          generated_devs << PaywalledDeveloper.new(hero: Faker::Lorem.sentence, bio: Faker::Lorem.paragraph(sentence_count: 10), avatar_url: SeedsHelper.developer_avatar_urls.sample)
        end
        return generated_devs.first if num == 1
        generated_devs
      end
    end
  end
end
