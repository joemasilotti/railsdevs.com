module FeatureHelper
  # Toggle a single feature flag and disable the rest.
  def stub_feature_flag(feature_name, enabled = true)
    stub = proc do |arg|
      (arg == feature_name) ? enabled : false
    end

    Feature.stub(:enabled?, stub) do
      yield
    end
  end
end
