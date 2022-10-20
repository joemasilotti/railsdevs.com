module StubHelper
  extend ActiveSupport::Concern

  included do
    def stub_const(object, name, val = nil, &block)
      original_values = {}

      if object.send(:const_defined?, name)
        original_value = object.send(:const_get, name)
        original_values[name] = original_value
      end

      silence_warnings { object.send(:const_set, name, val) }

      yield
    ensure
      if original_values.key?(name)
        silence_warnings { object.send(:const_set, name, original_values[name]) }
      else
        object.send(:remove_const, name)
      end
    end
  end
end
