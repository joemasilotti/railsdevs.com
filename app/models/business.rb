class Business < ApplicationRecord
  include Avatarable

  belongs_to :user

  validates :name, presence: true
  validates :company, presence: true
end
