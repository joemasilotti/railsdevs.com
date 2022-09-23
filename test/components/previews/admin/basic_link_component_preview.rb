module Admin
  class BasicLinkComponentPreview < ViewComponent::Preview
    # @label With title and path
    # @param title text
    # @param path url
    def default(title: "title", path: "#")
      render_with_template(locals: {title:, path:})
    end

    # @label With title, path and external:
    # @param title text
    # @param path url
    # @param external toggle
    def with_external(title: "title", path: "#", external: true)
      render_with_template(locals: {title:, path:, external:})
    end

    # @label With title, path, external: and data:
    # @param title text
    # @param path url
    # @param external toggle
    # @param data [Hash] text
    def with_data(title: "title", path: "#", external: true, data: {})
      render_with_template(locals: {title:, path:, external:, data:})
    end
  end
end
