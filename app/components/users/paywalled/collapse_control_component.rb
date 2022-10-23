module Users
  module Paywalled
    class CollapseControlComponent < ApplicationComponent
      attr_reader :title

      def initialize(title)
        @title = title
      end
    end
  end
end
