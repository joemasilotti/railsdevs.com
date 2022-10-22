# frozen_string_literal: true

class Users::Paywalled::CollapseControlComponent < CollapseControlComponent
  renders_one :cta, -> (user:) do
    Users::PaywalledComponent.new(user: user, paywalled: nil, size: :extra_small)
  end
end
