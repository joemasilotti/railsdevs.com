module MetaTagsHelper
  extend ActiveSupport::Concern

  included do
    def assert_meta(property:, content: nil, content_begin_with: nil, content_end_with: nil, count: 1)
      selector = "meta[property='#{property}']"

      selector +=
        if content_begin_with.present?
          "[content^='#{content_begin_with}']"
        elsif content_end_with.present?
          "[content$='#{content_end_with}']"
        elsif content.present?
          "[content='#{content}']"
        else
          ""
        end

      assert_selector selector, visible: false, count: count
    end
  end
end
