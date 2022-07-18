class WorkLocation < ApplicationRecord
  TYPES = %i[in_person remote hybrid willing_to_relocate].freeze

  belongs_to :developer

  def missing_fields?
    TYPES.none? { |t| send(t) }
  end

  def humanize
    TYPES.select { |t| send(t) }.map { |t| t.to_s.humanize }.to_sentence
  end
end
