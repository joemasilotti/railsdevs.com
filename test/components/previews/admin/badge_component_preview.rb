module Admin
  class BadgeComponentPreview < ViewComponent::Preview
    # @param title text
    def default(title: "Active")
      render_with_template(locals: {title:})
    end
  end
end
