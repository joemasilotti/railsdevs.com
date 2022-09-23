module Admin
  class ListComponentPreview < ViewComponent::Preview
    # @!group with_cta

    def button_cta
    end

    def link_cta
    end

    # @!endgroup

    # @!group with_item

    # @label Item with title and body
    def item_with_title_and_body
    end

    # @label Item with title, body and subtitle
    def item_with_subtitle
    end

    # @label Item with title, body, subtitle and path
    def item_with_path
    end

    # @label Item with title, body, subtitle:, path:, and id:
    def item_with_id
    end

    # @label Item with title, body, subtitle:, path:, id: and aside slot
    def item_with_aside
    end

    # @!endgroup
  end
end
