class SearchStatusComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    developer.actively_looking? || developer.open? || developer.not_interested?
  end

  def icon_tag
    inline_svg_tag "icons/solid/#{icon}.svg", class: icon_classes.join(" ")
  end

  def text_classes
    if developer.actively_looking?
      "text-green-700"
    elsif developer.open? || developer.not_interested?
      "text-gray-900"
    end
  end

  def humanize(enum_value)
    Developer.human_attribute_name "search_status.#{enum_value}"
  end

  private

  def icon
    if developer.actively_looking? || developer.open?
      "search_circle"
    elsif developer.not_interested?
      "x_circle"
    end
  end

  def icon_classes
    %w[h-5 w-5].tap do |classes|
      if developer.actively_looking?
        classes << "text-green-500"
      elsif developer.open? || developer.not_interested?
        classes << "text-gray-400"
      end
    end
  end
end
