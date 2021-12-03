# frozen_string_literal: true

class PagyPaginatorComponent < ApplicationComponent
  include PagyHelper
  renders_one :loading_icon

  attr_reader :id, :pagy, :url_array, :container_classes, :view_component

  def initialize(id:, pagy:, url_array:, container_classes:, direction: :bottom)
    @id = id
    @pagy = pagy
    @url_array = url_array
    @container_classes = container_classes
    @direction = direction
  end

  def before_render
    add_page_to_url_array
    set_view_component
  end

  def add_page_to_url_array
    if @url_array.last.is_a?(Hash)
      @url_array.last[:page] = @pagy.next
    else
      @url_array << {page: @pagy.next}
    end
  end

  def set_view_component
    @view_component = case @direction
                      when :bottom
                        BottomComponent
                      when :top
                        TopComponent
    end
  end

  class BottomComponent < PagyPaginatorComponent
    def turbo_stream_action
      "append"
    end
  end

  class TopComponent < PagyPaginatorComponent
    def turbo_stream_action
      "prepend"
    end
  end
end
