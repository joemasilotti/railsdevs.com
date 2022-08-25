module Admin
  class ListItemComponent < ApplicationComponent
    renders_one :aside

    attr_reader :title, :body, :path, :subtitle

    def initialize(title, body, path: nil, subtitle: nil)
      @title = title
      @body = body
      @path = path
      @subtitle = subtitle
    end
  end
end
