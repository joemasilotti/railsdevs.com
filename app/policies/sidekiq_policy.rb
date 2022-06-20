class SidekiqPolicy
  private attr_reader :user, :environment

  def initialize(user, environment: Rails.env)
    @user = user
    @environment = environment
  end

  def visible?
    user.admin? || environment.development?
  end
end
