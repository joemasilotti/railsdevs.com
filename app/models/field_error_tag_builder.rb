class FieldErrorTagBuilder
  def initialize(html_tag, instance)
    @html_tag = html_tag
    @instance = instance
  end

  def error_field
    if /<label/.match?(@html_tag)
      wrapped_label_tag_with_errors
    else
      @html_tag
    end
  end

  def closing_tag_index
    color_free_tag.index("</label>")
  end

  def color_free_tag
    @color_free_tag ||= @html_tag.gsub(text_color_regex, "")
  end

  private

  def wrapped_label_tag_with_errors
    %(<div class="contents text-red-600">#{color_free_tag_with_errors}</div>).html_safe
  end

  def color_free_tag_with_errors
    %(<div class="contents text-red-600">#{color_free_tag.insert(closing_tag_index, error_message_tag)}</div>)
  end

  def error_message_tag
    errors = Array(@instance.error_message).to_sentence
    " #{errors}"
  end

  def text_color_regex
    @text_color_regex ||= %r{text-\w*-\d*[^\s"]}
  end
end
