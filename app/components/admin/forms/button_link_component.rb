module Admin
  module Forms
    class ButtonLinkComponent < ApplicationComponent
      private attr_reader :title, :path

      def initialize(title, path)
        @title = title
        @path = path
      end

      def call
        link_to title, path, class: "bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
      end
    end
  end
end
