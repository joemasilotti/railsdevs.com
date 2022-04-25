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
        Link.new(t("nav_bar.base_component.developers"), developers_path),
        Link.new(t("nav_bar.base_component.pricing"), pricing_path),
        Link.new(t("nav_bar.base_component.about"), about_path)
      ]
    end
  end
end
