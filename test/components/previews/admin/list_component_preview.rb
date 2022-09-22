module Admin
  class ListComponentPreview < ViewComponent::Preview
    # @!group with_cta

    def button_cta(title: "cta", form: "form")
      render_with_template(locals: {title:, form:})
    end

    def link_cta(title: "cta")
      render_with_template(locals: {title:})
    end

    # @!endgroup

    # @!group with_item

    # @label Item with title and body
    def item_with_title_and_body(title: "title", body: "body")
      render_with_template(locals: {title:, body:})
    end

    # @label Item with title, body and subtitle
    def item_with_subtitle(title: "title", body: "body", subtitle: "subtitle")
      render_with_template(locals: {title:, body:, subtitle:})
    end

    # @label Item with title, body, subtitle and path
    def item_with_path(title: "title", body: "body", path: "#")
      render_with_template(locals: {title:, body:, path:})
    end

    # @label Item with title, body, subtitle:, path:, and id:
    def item_with_id(title: "title", body: "body", id: "id")
      render_with_template(locals: {title:, body:, id:})
    end

    # @label Item with title, body, subtitle:, path:, id: and aside slot
    def item_with_aside
    end

    # @!endgroup
  end
end
