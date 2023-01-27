module Admin
  module Tables
    module CellAlignment
      def align_class
        (align == :right) ? "text-right" : "text-left"
      end
    end
  end
end
