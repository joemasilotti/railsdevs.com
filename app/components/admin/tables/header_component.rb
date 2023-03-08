module Admin
  module Tables
    class HeaderComponent < ApplicationComponent
      include CellAlignment

      attr_reader :title, :tooltip, :align

      def initialize(title = nil, tooltip = nil, align: :left)
        @title = title
        @tooltip = tooltip
        @align = align
      end

      def call
        tag.th title || content, scope: "col", title: tooltip,
          class: class_names("px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider", align_class)
      end
    end
  end
end
