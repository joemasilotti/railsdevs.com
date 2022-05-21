class Admin::Prompt < ApplicationRecord
  validates :name, presence: true, length: {maximum: 140}
end
