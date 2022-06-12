module Developers
  class EmptyStateComponent < ApplicationComponent
    def initialize(show_unseeded_message: false)
      @show_unseeded_message = show_unseeded_message
    end

    def call
      title = t(".title")
      body = if show_unseeded_message?
        t(".unseeded_body_html")
      else
        t(".body")
      end

      render ::EmptyStateComponent.new(title:, body:, icon: "icons/outline/user_group.svg")
    end

    private

    def show_unseeded_message?
      @show_unseeded_message
    end
  end
end
