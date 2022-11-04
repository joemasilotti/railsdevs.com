class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def new?
    create?
  end

  def create?
    false
  end

  def show?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def admin?
    user&.admin?
  end

  def record_owner?
    user == record.user
  end
end
