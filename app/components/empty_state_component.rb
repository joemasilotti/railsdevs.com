class EmptyStateComponent < ApplicationComponent
  attr_reader :title, :body, :icon

  def initialize(title:, body:, icon:)
    @title = title
    @body = body
    @icon = icon
  end
end
