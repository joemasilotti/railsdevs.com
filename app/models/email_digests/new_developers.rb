class EmailDigests::NewDevelopers
  def send_daily_digest
    yesterday = 1.day.ago.all_day
    developers = Developer.visible.where(created_at: yesterday).order(:created_at)
    return if developers.empty?

    businesses = Business.daily_developer_notifications

    log :daily, businesses: businesses.count, developers: developers.count
    send_emails(developers:, businesses:)
  end

  def send_weekly_digest
    return unless Time.current.monday?

    prev_7_days = 7.days.ago.beginning_of_day..1.day.ago.end_of_day
    developers = Developer.visible.where(created_at: prev_7_days).order(:created_at)
    return if developers.empty?

    businesses = Business.weekly_developer_notifications

    log :weekly, businesses: businesses.count, developers: developers.count
    send_emails(developers:, businesses:)
  end

  private

  def log(digest, businesses:, developers:)
    Rails.logger.info "#{self.class}##{digest}: "\
      "Sending #{businesses} businesse(s) emails about #{developers} new developer(s)."
  end

  def send_emails(developers:, businesses:)
    developers = developers.to_a
    businesses.find_each do |business|
      next unless Businesses::Permission.new(business.user.payment_processor).active_subscription?
      BusinessMailer.with(business:, developers:).developer_profiles.deliver_later
    end
  end
end
