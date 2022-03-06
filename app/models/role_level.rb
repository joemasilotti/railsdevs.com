class RoleLevel < ApplicationRecord
  TYPES = %i[junior mid senior principal c_level].freeze

  belongs_to :developer

  def missing_fields?
    TYPES.none? { |t| send(t) }
  end
end
