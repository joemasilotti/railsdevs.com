class Admin::TableHeaderComponent < ApplicationComponent
  attr_reader :title, :first

  def initialize(title, first: false)
    @title = title
    @first = first
  end

  def call
    tag.th title, scope: "col", class: class_names("py-3.5 text-left text-sm font-semibold text-gray-900", {
      "pl-4 pr-3 sm:pl-6": first,
      "px-3": !first
    })
  end
end
