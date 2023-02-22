module Admin
  module Forms
    class ContainerComponentPreview < ViewComponent::Preview
      # @param title text
      # @param description textarea
      def default(title: "Title", description: "Description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # @param title text
      # @param description textarea
      def with_aside(title: "Title", description: "Description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # @param title text
      # @param description textarea
      def with_button_group(title: "Title", description: "Description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # @param title text
      # @param description textarea
      def with_content(title: "Title", description: "Description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # @label with content, aside and button_group
      # @param title text
      # @param description textarea
      def with_content_and_aside_and_button_group(title: "Title", description: "Description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end
    end
  end
end
