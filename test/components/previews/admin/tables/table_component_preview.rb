module Admin
  module Tables
    class TableComponentPreview < ViewComponent::Preview
      def default
        render Admin::Tables::TableComponent.new do |table|
          table.with_header "name"
          table.with_header "github"
          table.with_header "email"

          table.with_row do |row|
            row.with_cell(primary: true) { Faker::Name.name }
            row.with_cell { Faker::Internet.username }
            row.with_cell { Faker::Internet.email }
          end

          table.with_row do |row|
            row.with_cell(primary: true) { Faker::Name.name }
            row.with_cell { Faker::Internet.username }
            row.with_cell { Faker::Internet.email }
          end

          table.with_row do |row|
            row.with_cell(primary: true) { Faker::Name.name }
            row.with_cell { Faker::Internet.username }
            row.with_cell { Faker::Internet.email }
          end
        end
      end

      # @!group Header

      def default_header
        render Admin::Tables::TableComponent.new do |table|
          table.with_header "name"
        end
      end

      def header_right_aligned
        render Admin::Tables::TableComponent.new do |table|
          table.with_header "name", align: :right
        end
      end

      # @!endgroup

      # @!group Cell

      def default_cell
        render Admin::Tables::TableComponent.new do |table|
          table.with_row do |row|
            row.with_cell { Faker::Name.name }
          end
        end
      end

      def primary_cell
        render Admin::Tables::TableComponent.new do |table|
          table.with_row do |row|
            row.with_cell(primary: true) { Faker::Name.name }
          end
        end
      end

      def cell_right_aligned
        render Admin::Tables::TableComponent.new do |table|
          table.with_row do |row|
            row.with_cell(align: :right) { Faker::Name.name }
          end
        end
      end

      # @!endgroup
    end
  end
end
