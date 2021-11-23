class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :image, :data

  def initialize(developer:, data: {})
    @image = developer.avatar.attached? ? developer.avatar : DEFAULT_AVATAR
    @data = data
  end
end
