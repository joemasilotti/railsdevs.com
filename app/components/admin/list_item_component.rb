module Admin
  class ListItemComponent < ApplicationComponent
    renders_one :aside

    attr_reader :title, :body, :path, :subtitle, :id

    def initialize(title, body, path: nil, subtitle: nil, id: nil)
      @title = title
      @body = body
      @path = path
      @subtitle = subtitle
      @id = id
    end
  end
end
