class DeveloperRegistration
  Result = Struct.new(:success?, :developer)

  private attr_reader :options, :user

  def initialize(options, user:)
    @options = options
    @user = user
  end

  def create
    developer = user.build_developer(options)

    if developer.save
      send_admin_notification(developer)
      send_welcome_email(developer)
      Result.new(true, developer)
    else
      Result.new(false, developer)
    end
  end

  private

  def send_admin_notification(developer)
    NewDeveloperProfileNotification.with(developer:).deliver_later(User.admin)
  end

  def send_welcome_email(developer)
    DeveloperMailer.with(developer:).welcome_email.deliver_later
  end
end
