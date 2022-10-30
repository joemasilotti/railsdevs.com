class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :avatarable, :variant, :data

  def initialize(avatarable:, variant: nil, classes: nil, data: {})
    @avatarable = avatarable
    @variant = variant
    @classes = classes
    @data = data
  end

  def classes
    [
      (@classes || "h-24 w-24 sm:h-32 sm:w-32 ring-4 ring-white"),
      "object-cover rounded-full",
      "bg-navy": Feature.enabled?(:redesign),
      "bg-gray-300": !Feature.enabled?(:redesign)
    ]
  end

  def avatar_image_url
    return image_path(DEFAULT_AVATAR) unless avatarable&.avatar&.attached?
    url_for variant ? avatarable.avatar.variant(variant) : avatarable.avatar
  end

  def avatar_image_2x_url
    return image_path(DEFAULT_AVATAR) unless avatarable&.avatar&.attached?
    url_for variant ? avatarable.avatar.variant("#{variant}_2x".to_sym) : avatarable.avatar
  end

  def name
    "#{avatarable.class.name}'s"
  end
end
