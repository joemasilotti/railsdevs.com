class ToastMessageComponent < ViewComponent::Base
  include ComponentWithIcon

  renders_one :title
  renders_many :messages

  def initialize(icon:, color: :blue, messages_tag: :div)
    @icon = icon
    @color = color
    @messages_tag = messages_tag
  end

  def color_styles(concern:)
    NAMED_STYLES.dig(@color, concern) || ""
  end

  def background_classes
    color_styles(concern: :bg)
  end

  def icon_classes
    color_styles(concern: :icon)
  end

  def title_classes
    color_styles(concern: :title)
  end

  def messages_classes
    messages_classes = color_styles(concern: :message)
    messages_classes << " mt-2 pl-5" unless @messages_tag == :div

    messages_classes
  end

  private

  NAMED_STYLES = {
    blue: {
      bg: "bg-blue-50",
      icon: "text-blue-400",
      title: "text-blue-800",
      message: "text-blue-700"
    },
    red: {
      bg: "bg-red-50",
      icon: "text-red-400",
      title: "text-red-800",
      message: "text-red-700"
    }
  }.freeze
end
