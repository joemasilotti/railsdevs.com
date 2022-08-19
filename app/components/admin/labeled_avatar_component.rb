class Admin::LabeledAvatarComponent < ApplicationComponent
  attr_reader :avatarable, :title, :path, :subtitle

  def initialize(avatarable, title:, path: nil, subtitle: nil)
    @avatarable = avatarable
    @title = title
    @path = path
    @subtitle = subtitle
  end
end
