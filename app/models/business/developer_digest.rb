class Business::DeveloperDigest
  attr_reader :developers

  def initialize(timeframe:)
    @timeframe = timeframe
    @developers = new_developers(timeframe:)
    @businesses = recipients(timeframe:)
  end

  def digest
    if @developers.empty?
      puts "There are no new developers to mention at this time." unless Rails.env.test?
    else
      total_emails = @businesses.length
      puts "Sending #{@timeframe} digests to #{total_emails} businesses:" unless Rails.env.test?

      @businesses.each_with_index do |business, i|
        BusinessMailer.with(business:, developers: @developers).developer_profiles.deliver_now
        puts "Progress - #{((i + 1.0) / total_emails) * 100}%" unless Rails.env.test?
      end
    end
  end

  private

  def new_developers(timeframe:)
    query_range = case timeframe
    when :daily
      1.day.ago..Time.now
    when :weekly
      1.week.ago..Time.now
    else
      raise ArgumentError.new("#{timeframe} is not a valid range for digests.")
    end

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
