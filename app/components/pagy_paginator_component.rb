class PagyPaginatorComponent < ApplicationComponent
  include PagyHelper

  renders_one :loading_icon

  attr_reader :id, :pagy, :url_array, :container_classes, :view_component

  def initialize(id:, pagy:, url_array:, container_classes: nil, options: {})
    @id = id
    @pagy = pagy
    @url_array = url_array << options
    @container_classes = container_classes
  end

  def before_render
    add_page_to_url_array
  end

  def add_page_to_url_array
    if @url_array.last.is_a?(Hash)
      @url_array.last[:page] = @pagy.next
    else
      @url_array << {page: @pagy.next}
    end
  end
end
