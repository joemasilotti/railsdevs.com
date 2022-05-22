class RoleType < ApplicationRecord
  TYPES = %i[part_time_contract full_time_contract full_time_employment].freeze

  belongs_to :developer

  def missing_fields?
    TYPES.none? { |t| send(t) }
  end

  def humanize
    TYPES.select { |t| send(t) }.map { |t| t.to_s.humanize }.to_sentence
  end
end
