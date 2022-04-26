class BusinessRegistration
  Result = Struct.new(:success?, :business)

  private attr_reader :options, :user

  def initialize(options, user:)
    @options = options
    @user = user
  end

  def create
    business = user.build_business
    business.assign_attributes(options)

    if business.save
      send_admin_notification(business)
      send_welcome_email(business)
      Result.new(true, business)
    else
      Result.new(false, business)
    end
  end

  private

  def send_admin_notification(business)
    NewBusinessNotification.with(business:).deliver_later(User.admin)
  end

  def send_welcome_email(business)
    BusinessMailer.with(business:).welcome_email.deliver_later
  end
end
