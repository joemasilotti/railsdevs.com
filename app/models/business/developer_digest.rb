class Business::DeveloperDigest
  def initialize(timeframe:)
    @developers = new_developers(timeframe: timeframe)
    @businesses = recipients(timeframe: timeframe)
  end

  def digest
    if @developers.empty?
      puts "There are no new developers to mention at this time." unless Rails.env.test?
    else
      total_emails = @businesses.length
      puts "Sending daily digests to #{total_emails} businesses:" unless Rails.env.test?

      @businesses.each_with_index do |business, i|
        BusinessMailer.with(business:, developers: @developers).developer_profiles.deliver_now
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%"
      end
    end
  end

  private

  def new_developers(timeframe:)
    query_range = timeframe == :daily ? (Date.yesterday..Date.current.to_date) : ((Date.current.to_date - 7.days)..Date.current.to_date)

    Developer.where(created_at: query_range)
  end

  def recipients(timeframe:)
    case timeframe
    when :daily
      Business.daily_developer_notifications
    when :weekly
      Business.weekly_developer_notifications
    else
      raise ArgumentError.new("#{timeframe} is not a valid range for digests.")
    end
  end
end
