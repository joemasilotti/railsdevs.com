class Admin::HeadingComponent < ApplicationComponent
  private attr_reader :title

  def initialize(title)
    @title = title
  end

  def call
    tag.div class: "flex items-center justify-center" do
      tag.h1 title, class: "mt-6 text-center text-3xl font-extrabold"
    end
  end
end
