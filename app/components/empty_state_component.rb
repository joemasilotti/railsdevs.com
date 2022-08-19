class EmptyStateComponent < ApplicationComponent
  attr_reader :title, :icon, :body, :cta, :cta_path, :cta_icon

  def initialize(title, icon, body: nil, cta: nil, cta_path: nil, cta_icon: nil)
    @title = title
    @icon = icon
    @body = body
    @cta = cta
    @cta_path = cta_path
    @cta_icon = cta_icon
  end

  def cta?
    cta.present? && cta_path.present? && cta_icon.present?
  end
end
