class ToastMessageComponent < ApplicationComponent
  include ComponentWithIcon

  renders_one :title
  renders_many :messages

  attr_reader :icon, :color, :messages_tag

  def initialize(icon:, color: :blue, messages_tag: :div)
    @icon = icon
    @color = color
    @messages_tag = messages_tag
  end

  def messages_classes
    messages_classes = yass(message: @color)
    messages_classes << " mt-2 pl-5" unless @messages_tag == :div

    messages_classes
  end
end
