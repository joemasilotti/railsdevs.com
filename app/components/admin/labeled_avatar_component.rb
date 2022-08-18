class Admin::LabeledAvatarComponent < ApplicationComponent
  attr_reader :avatarable, :title, :title_path, :subtitle

  def initialize(avatarable, title:, title_path: nil, subtitle: nil)
    @avatarable = avatarable
    @title = title
    @title_path = title_path
    @subtitle = subtitle
  end
end
