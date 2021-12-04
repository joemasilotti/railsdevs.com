class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :avatarable, :image, :data

  def initialize(avatarable:, classes: nil, data: {})
    @avatarable = avatarable
    @image = avatarable&.avatar&.attached? ? avatarable.avatar : DEFAULT_AVATAR
    @classes = classes
    @data = data
  end

  def classes
    @classes || "h-24 w-24 sm:h-32 sm:w-32 ring-4 ring-white"
  end

  def name
    "#{avatarable.class.name}'s"
  end
end
