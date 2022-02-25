module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar

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
