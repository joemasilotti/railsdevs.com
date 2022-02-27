module MetaTagsHelper
  extend ActiveSupport::Concern

  included do
    def assert_title_contains(content)
      assert_select "title", text: /^#{content}/
    end

    def assert_description_contains(content)
      assert_select "meta[property=description][content~=?]", content
    end

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

      assert_selector selector, visible: false, count:
    end
  end
end
