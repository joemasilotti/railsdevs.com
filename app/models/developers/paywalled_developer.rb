module Developers
  class PaywalledDeveloper
    attr_reader :hero, :bio, :avatar_file_name

    def initialize(hero:, bio:, avatar_file_name:)
      @hero = hero
      @bio = bio
      @avatar_file_name = avatar_file_name
    end

    class << self
      FOLDER_PREFIX = "paywalled_developers"
      AVATAR_FILE_NAMES = %w[paywalled-dev-1.jpeg paywalled-dev-2.jpeg paywalled-dev-3.jpeg]

      def generate(num = 1)
        generated_devs = []
        enumerator = AVATAR_FILE_NAMES.shuffle.cycle.each
        num.times do
          generated_devs << PaywalledDeveloper.new(hero: Faker::Lorem.sentence, bio: Faker::Lorem.paragraph(sentence_count: 10), avatar_file_name: "#{FOLDER_PREFIX}/#{enumerator.next}")
        end
        return generated_devs.first if num == 1
        generated_devs
      end
    end
  end
end
