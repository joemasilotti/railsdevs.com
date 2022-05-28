class Admin::Prompt < ApplicationRecord
  has_many :prompts, class_name: "Developers::PromptResponse", dependent: :destroy

  validates :name, presence: true, length: {maximum: 140}
end
