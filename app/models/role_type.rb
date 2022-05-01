class RoleType < ApplicationRecord
  TYPES = %i[part_time_contract full_time_contract full_time_employment].freeze

  after_commit :notify_admins_of_potential_hire, if: :changes_indicate_potential_hire?

  belongs_to :developer

  def missing_fields?
    TYPES.none? { |t| send(t) }
  end

  def humanize
    TYPES.select { |t| send(t) }.map { |t| t.to_s.humanize }.to_sentence
  end

  def only_full_time_employment?
    full_time_employment &&
      !part_time_contract? &&
      !full_time_contract?
  end

  private

  def changes_indicate_potential_hire?
    return false unless saved_change_to_full_time_employment?

    original_value, saved_value = saved_change_to_full_time_employment
    original_value && !saved_value
  end

  def notify_admins_of_potential_hire
    PotentialHireNotification.with(delevoper: developer, reason: :full_time_employment).deliver_later(User.admin)
  end
end
