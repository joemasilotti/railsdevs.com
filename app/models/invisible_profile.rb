class InvisibleProfile
  class UnknownReason < StandardError; end

  REASONS = %i[incomplete not_responding]

  attr_reader :reason

  def self.all
    REASONS.map { |r| with_reason(r) }
  end

  def self.with_reason(reason)
    unless REASONS.include?(reason.to_s.to_sym)
      raise UnknownReason.new("Unknown reason: '#{reason}'.")
    end

    new(reason)
  end

  def help_text
    # i18n-tasks-use t("invisible_profile.incomplete.help_text"))
    # i18n-tasks-use t("invisible_profile.not_responding.help_text"))
    I18n.t(:help_text, scope: [:invisible_profile, reason])
  end

  def message
    # i18n-tasks-use t("invisible_profile.incomplete.message"))
    # i18n-tasks-use t("invisible_profile.not_responding.message"))
    I18n.t(:message, scope: [:invisible_profile, reason])
  end

  def next_steps
    # i18n-tasks-use t("invisible_profile.incomplete.next_steps"))
    # i18n-tasks-use t("invisible_profile.not_responding.next_steps"))
    I18n.t(:next_steps, scope: [:invisible_profile, reason])
  end

  private

  def initialize(reason)
    @reason = reason
  end
end
