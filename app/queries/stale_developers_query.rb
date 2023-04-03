class StaleDevelopersQuery
  EARLIEST_TIME = 3.months.ago.beginning_of_day

  def stale_developers
    Developer.actively_looking_or_open
      .where(updated_at: ..EARLIEST_TIME)
  end
end
