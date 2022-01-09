module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar

    validates :avatar, content_type: ["image/png", "image/jpeg", "image/jpg"],
      max_file_size: 2.megabytes
    validate :avatar_is_attached?, on: :create

    private

    def avatar_is_attached?
      unless avatar.attached?
        errors.add(:avatar, "required")
      end
    end
  end
end
