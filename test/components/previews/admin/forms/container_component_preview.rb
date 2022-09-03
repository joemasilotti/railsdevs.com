module Admin
  module Forms
    class ContainerComponentPreview < ViewComponent::Preview
      # Form Container
      # ---------------
      # This is the form container
      #
      # @param title text
      # @param description textarea
      def default(title: "title", description: "description")
        render Admin::Forms::ContainerComponent.new(title, description)
      end

      # Form Container with aside
      # ---------------
      # This is the form container with an aside
      #
      # @param title text
      # @param description textarea
      def with_aside(title: "title", description: "description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # Form Container with button_group
      # ---------------
      # This is the form container a button group
      #
      # @param title text
      # @param description textarea
      def with_button_group(title: "title", description: "description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # Form Container with aside and button_group
      # ---------------
      # This is the form container with an aside and button group
      #
      # @param title text
      # @param description textarea
      def with_aside_and_button_group(title: "title", description: "description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # Form Container with content
      # ---------------
      # This is the form container with an aside and button group
      #
      # @param title text
      # @param description textarea
      def with_content(title: "title", description: "description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end

      # Form Container with content, aside and button_group
      # ---------------
      # This is the form container with an aside and button group
      #
      # @param title text
      # @param description textarea
      def with_content_and_aside_and_button_group(title: "title", description: "description")
        render_with_template(locals: {
          title: title,
          description: description
        })
      end
    end
  end
end
