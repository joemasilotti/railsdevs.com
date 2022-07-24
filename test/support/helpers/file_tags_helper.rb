module FileTagsHelper
  extend ActiveSupport::Concern

  included do
    def assert_tag_source(filename:, tag: "img")
      components = filename.split(".")
      assert page.find(tag)["src"].match?(/#{components.first}.*\.#{components.last}$/)
    end
  end
end
