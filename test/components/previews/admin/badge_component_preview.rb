module Admin
  class BadgeComponentPreview < ViewComponent::Preview
    def default(title: "active")
      render_with_template(locals: {title:})
    end
  end
end
