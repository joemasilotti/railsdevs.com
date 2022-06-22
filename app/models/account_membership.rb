class AccountMembership < ApplicationRecord
  belongs_to :user
  belongs_to :account

  enum role: %w[admin]
end
