class Admin::TableHeaderComponent < ApplicationComponent
  attr_reader :title, :align

  def initialize(title = nil, align: :left)
    @title = title
    @align = align
  end

  def call
    tag.th title || content, scope: "col", class: "px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider #{align_class}"
  end
end
