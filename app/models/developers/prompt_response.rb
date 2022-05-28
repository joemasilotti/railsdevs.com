module Developers
  class PromptResponse < ApplicationRecord
    belongs_to :prompt, class_name: "Admin::Prompt"
    belongs_to :developer

    validates :content, presence: true, length: {maximum: 280}
  end
end
