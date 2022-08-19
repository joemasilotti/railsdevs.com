class Admin::TableCellComponent < ApplicationComponent
  private attr_reader :first

  def initialize(first: false)
    @first = first
  end

  def call
    tag.td content, class: class_names("whitespace-nowrap py-4 text-sm", {
      "pl-4 pr-3 font-medium sm:pl-6": first,
      "pl-3 pr-4 text-gray-500 sm:pr-6": !first
    })
  end
end
