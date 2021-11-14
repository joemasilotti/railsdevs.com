module FileTagsHelper
  extend ActiveSupport::Concern

  included do
    def strip_file_type(filename:)
      filename.split(".").first
    end
  end
end
