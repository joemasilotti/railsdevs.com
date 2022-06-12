class EmptyStateComponent < ApplicationComponent
  attr_reader :title, :body, :unseeded_body, :icon

  def initialize(title:, body:, icon:, unseeded_body: nil)
    @title = title
    @body = body
    @unseeded_body = unseeded_body
    @icon = icon
  end

  private

  def show_unseeded_body?
    Rails.env.development? && @unseeded_body.present? && User.none?
  end
end
