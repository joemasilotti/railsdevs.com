module MetaHelper
  def open_graph_tags
    render(OpenGraphTagsComponent.new) unless content_for?(:open_graph_tags)
    content_for(:open_graph_tags)
  end
end
