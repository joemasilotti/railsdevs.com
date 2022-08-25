class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :avatarable, :variant, :classes, :data

  def initialize(avatarable:, variant: nil, classes: nil, data: {})
    @avatarable = avatarable
    @variant = variant
    @classes = classes
    @data = data
  end

  def image
    return DEFAULT_AVATAR unless avatarable&.avatar&.attached?
    variant ? avatarable.avatar.variant(variant) : avatarable.avatar
  end

  def image_2x
    return DEFAULT_AVATAR unless avatarable&.avatar&.attached?
    variant ? avatarable.avatar.variant("#{variant}_2x".to_sym) : avatarable.avatar
  end

  def name
    "#{avatarable.class.name}'s"
  end
end
