class Admin::Prompt < ApplicationRecord
  has_many :responses, class_name: "Developers::PromptResponse", dependent: :destroy
  scope :active, -> { where(active: true) }

  validates :name, presence: true, length: {maximum: 140}
end
