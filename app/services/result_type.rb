module ResultType
  extend ActiveSupport::Concern

  module ClassMethods
    def define_type(type)
      define_method "#{type}?" do
        true
      end
    end
  end

  def method_missing(m, *args, &block)
    m.ends_with?("?") ? false : super
  end

  def respond_to_missing?(*args)
    true
  end
end
