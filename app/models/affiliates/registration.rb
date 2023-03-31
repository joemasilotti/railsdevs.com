module Affiliates
  class Registration
    include ActiveModel::Model

    validates :agreement, acceptance: true
  end
end
