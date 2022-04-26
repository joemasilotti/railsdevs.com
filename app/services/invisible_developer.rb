class InvisibleDeveloper
  private attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def mark
    developer.invisible!
    send_invisiblize_notification
  end

  private

  def send_invisiblize_notification
    InvisiblizeDeveloperNotification.with(developer:).deliver_later(developer.user)
  end
end
