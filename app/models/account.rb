class Account < ApplicationRecord
  has_many :account_memberships
  has_many :users, through: :account_memberships

  delegate :name, to: :profile

  delegated_type :profile, types: %w[Business Developer]
end
