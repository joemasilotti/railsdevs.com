module Developers
  class OpenGraphTagsComponent < OpenGraphTagsComponent
    def initialize(developer:)
      @developer = developer
      @title = @developer.hero
    end

    def turbo_native_title
      t(".turbo_native_title")
    end

    def description
      @developer.bio
    end

    def url
      developer_url(@developer)
    end

    def image
      rails_blob_url(@developer.avatar) if @developer.avatar.attached?
    end

    def twitter_card
      "summary"
    end

    def twitter
      "@#{@developer.twitter}" if @developer.twitter.present?
    end
  end
end
