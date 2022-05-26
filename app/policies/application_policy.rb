class ApplicationPolicy
  include ActionPolicy::Policy::Core
  include ActionPolicy::Policy::Authorization
  include ActionPolicy::Policy::PreCheck
  include ActionPolicy::Policy::Reasons
  include ActionPolicy::Policy::Aliases
  include ActionPolicy::Policy::Scoping
  include ActionPolicy::Policy::Cache
  include ActionPolicy::Policy::CachedApply
  include ActionPolicy::Policy::Defaults

  # Rails-specific scoping extensions
  extend ActionPolicy::ScopeMatchers::ActiveRecord
  scope_matcher :active_record_relation, ActiveRecord::Relation
  extend ActionPolicy::ScopeMatchers::ActionControllerParams
  scope_matcher :action_controller_params, ActionController::Parameters

  # Active Support notifications
  prepend ActionPolicy::Policy::Rails::Instrumentation

  authorize :user, allow_nil: true

  alias_rule :new?, to: :create?
  alias_rule :edit?, to: :update?

  def index?
    false
  end

  def create?
    false
  end

  def destroy?
    false
  end

  def record_owner?
    user == record.user
  end
end
