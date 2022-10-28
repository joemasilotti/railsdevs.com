class ToggleComponent < ApplicationComponent
  attr_reader :title, :url

  def initialize(activated, title:, url:)
    @activated = activated
    @title = title
    @url = url
  end

  def activated?
    !!@activated
  end

  def method
    activated? ? :delete : :post
  end
end
