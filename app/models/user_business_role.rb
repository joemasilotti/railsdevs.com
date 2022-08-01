class UserBusinessRole < ApplicationRecord
  enum :role_type, %i[member admin]

  belongs_to :user
  belongs_to :business
end
