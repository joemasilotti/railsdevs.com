class User < ApplicationRecord
  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_one :developer
end
