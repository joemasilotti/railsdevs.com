module Developers
  class EmptyStateComponent < ApplicationComponent
    def initialize(seedable: false)
      @seedable = seedable
    end

    def call
      title = t(".title")
      body = if show_seed_message?
        t(".unseeded_body_html")
      else
        t(".body")
      end

      render ::EmptyStateComponent.new(title:, body:, icon: "icons/outline/user_group.svg")
    end

    private

    def show_seed_message?
      @seedable && Developer.none?
    end
  end
end
