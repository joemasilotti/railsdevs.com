class DeveloperAvatarComponent < ViewComponent::Base
  def initialize(options)
    @developer = options[:developer]
    @data = options[:data].presence || {}
  end

  def developer_avatar_tag
    avatar_attached? ? developer_avatar_image : default_avatar
  end

  private

  attr_reader :developer, :data

  def avatar_attached?
    developer.avatar.attached?
  end

  def developer_avatar_image
    image_tag developer_avatar,
      alt: developer_name,
      data: data,
      class: developer_avatar_image_classes
  end

  def default_avatar
    content_tag :div, class: default_avatar_classes do
      concat inline_svg_tag "icons/avatar.svg", class: inline_svg_classes
    end
  end

  def developer_avatar
    @developer_avatar ||= developer.avatar
  end

  def developer_name
    @developer_name ||= developer.name
  end

  def inline_svg_classes
    "relative z-10 h-full w-full text-gray-300"
  end

  def developer_avatar_image_classes
    "object-cover h-24 w-24 bg-gray-300 rounded-full ring-4 ring-white sm:h-32 sm:w-32"
  end

  def default_avatar_classes
    "relative h-24 w-24 rounded-full ring-4 ring-white overflow-hidden bg-gray-100 sm:h-32 sm:w-32"
  end
end
