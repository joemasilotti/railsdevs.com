# TODO: Refactor naming to be generic to Developer and Business.
class AvatarComponent < ViewComponent::Base
  DEFAULT_AVATAR = "avatar.png"

  attr_reader :image, :data

  def initialize(developer:, classes: nil, data: {})
    @image = developer&.avatar&.attached? ? developer.avatar : DEFAULT_AVATAR
    @classes = classes
    @data = data
  end

  def classes
    @classes || "h-24 w-24 sm:h-32 sm:w-32 ring-4 ring-white"
  end
end
