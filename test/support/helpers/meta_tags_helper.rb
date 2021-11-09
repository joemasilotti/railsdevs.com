module MetaTagsHelper
  extend ActiveSupport::Concern

  included do
    def assert_meta(property:, content: nil, content_end_with: nil, count: 1)
      selector = "meta[property='#{property}']"
      selector += "[content='#{content}']" if content.present?
      selector += "[content$='#{content}']" if content_end_with.present?

      assert_selector selector, visible: false, count: count
    end
  end
end
