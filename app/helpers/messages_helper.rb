module MessagesHelper
  def html_truncate_message_body(body)
    AutoHtml::Pipeline.new(
      AutoHtml::HtmlEscape.new,
      AutoHtml::SimpleFormat.new
    ).call(truncate_message_body(body))
  end

  def truncate_message_body(body)
    truncate(body, length: 200, separator: " ", escape: false, omission: "... (continued)")
  end
end
