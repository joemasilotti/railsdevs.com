class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user

  enum role: {
    owner: 1
  }
end
