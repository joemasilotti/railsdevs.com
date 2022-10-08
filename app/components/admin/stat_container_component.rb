module Admin
  class StatContainerComponent < ApplicationComponent
    renders_many :stats, StatComponent

    def grid_cols_class
      case stats.count
      when 1 then "sm:grid-cols-1"
      when 2 then "sm:grid-cols-2"
      when 3 then "sm:grid-cols-3"
      when 4 then "sm:grid-cols-4"
      else raise "Too many stats: #{stats.count}."
      end
    end

    def max_w_class
      case stats.count
      when 1 then "max-w-xs"
      when 2 then "max-w-xl"
      when 3 then "max-w-3xl"
      when 4 then "max-w-5xl"
      end
    end
  end
end
