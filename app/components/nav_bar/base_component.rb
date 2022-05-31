module NavBar
  class BaseComponent < ApplicationComponent
    private attr_reader :user

    def initialize(user)
      @user = user
    end

    def component
      if user.present?
        NavBar::UserComponent.new(user, links:)
      else
        NavBar::GuestComponent.new(links:)
      end
    end

    private

    def links
      [
        Link.new(t(".developers"), developers_path),
        Link.new(t(".pricing"), pricing_path),
        Link.new(t(".about"), about_path)
      ]
    end
  end
end
