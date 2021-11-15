class TagColorManipulator
  def initialize(element)
    @element = element
  end

  def remove_text_color
    @element.gsub(text_color_regex, "")
  end

  private

  def text_color_regex
    @text_color_regex ||= %r{text-\w*-\d*[^\s"]}
  end

end
