module Users
  class Permission
    private attr_reader :user, :resource, :public_key

    def initialize(user, resource = nil, public_key: nil)
      @user = user
      @resource = resource
      @public_key = public_key
    end

    def authorized?
      customer? || owner? || public_access?
    end

    private

    def customer?
      user&.permissions&.active_subscription?
    end

    def owner?
      user.present? && resource&.user == user
    end

    def public_access?
      resource&.valid_public_profile_access?(public_key)
    end
  end
end
