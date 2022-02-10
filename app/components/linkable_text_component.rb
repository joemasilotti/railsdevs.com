class LinkableTextComponent < ApplicationComponent
  attr_reader :title, :url, :options

  def initialize(title, options = {})
    @title = title
    @url = options.delete(:url)
    @options = options
  end

  def link?
    @url.present?
  end
end
