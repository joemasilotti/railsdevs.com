module PunditHelper
  extend ActiveSupport::Concern

  included do
    def stub_not_authorized_pundit_policy(user, object_class, method, policy_class, &block)
      raises_exception = ->(actual_user, actual_object_class, actual_method, options) do
        assert_equal user, actual_user
        assert_kind_of object_class, actual_object_class
        assert_equal method, actual_method
        assert_equal options, {policy_class:}
        raise Pundit::NotAuthorizedError.new
      end

      Pundit.stub(:authorize, raises_exception) do
        assert_raises Pundit::NotAuthorizedError do
          block.call
        end
      end
    end
  end
end
