module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar do |attachable|
      attachable.variant :thumb, resize_to_limit: [32, 32]
      attachable.variant :thumb_2x, resize_to_limit: [64, 64]
      attachable.variant :medium, resize_to_limit: [128, 128]
      attachable.variant :medium_2x, resize_to_limit: [256, 256]
    end

    validates :avatar, content_type: ["image/png", "image/jpeg", "image/jpg"],
      max_file_size: 2.megabytes
    validates :avatar, attached: true, on: :create

    before_save :anonymize_avatar_filename

    private

    def anonymize_avatar_filename
      if avatar.attached?
        avatar.blob.filename = "avatar#{avatar.filename.extension_with_delimiter}"
      end
    end
  end
end
