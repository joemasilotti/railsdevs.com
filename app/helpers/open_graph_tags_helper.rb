module OpenGraphTagsHelper
  def open_graph_tags(options = {})
    content_for(:open_graph_tags) do
      component = options.delete(:component) || OpenGraphTagsComponent
      render component.new(**options)
    end
  end

  def render_open_graph_tags
    content_for(:open_graph_tags) || render(OpenGraphTagsComponent.new)
  end
end
