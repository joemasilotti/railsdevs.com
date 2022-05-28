ColdMessage = Struct.new(:message, :show_hiring_fee_terms, keyword_init: true) do
  def developer
    message.conversation.developer
  end

  def business
    message.conversation.business
  end
end
