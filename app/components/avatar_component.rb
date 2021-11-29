# TODO: Refactor naming to be generic to Developer and Business.
class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :image, :data

  def initialize(developer:, data: {})
    @image = developer.avatar.attached? ? developer.avatar : DEFAULT_AVATAR
    @data = data
  end
end
