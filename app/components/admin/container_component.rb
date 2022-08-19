module Admin
  class ContainerComponent < ApplicationComponent
    def call
      tag.div content, class: "min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8"
    end
  end
end
