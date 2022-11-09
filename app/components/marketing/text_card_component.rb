class Marketing::TextCardComponent < ApplicationComponent
  def initialize(title:, text:, xl_title: false)
    @title = title
    @text = text
    @xl_title = xl_title
  end
end
