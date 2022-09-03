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
    end
  end
end
