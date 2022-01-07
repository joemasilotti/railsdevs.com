module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar

    validates :avatar, content_type: ["image/png", "image/jpeg", "image/jpg"],
      max_file_size: 2.megabytes

    validate :avatar_validation, on: :create

    private

    def avatar_validation
      if avatar.attached? == false
        errors.add(:avatar, "required")
      end
    end
  end
end
