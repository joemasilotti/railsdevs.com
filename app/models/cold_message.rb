ColdMessage = Struct.new(:message, :messageable, :show_hiring_fee_terms, :tips, keyword_init: true) do
  def developer
    message.conversation.developer
  end

  def business
    message.conversation.business
  end
end
