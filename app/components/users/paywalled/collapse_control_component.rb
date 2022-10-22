class Users::Paywalled::CollapseControlComponent < CollapseControlComponent
  renders_one :cta, ->(user:) do
    Users::PaywalledComponent.new(user, nil, size: :extra_small)
  end
end
