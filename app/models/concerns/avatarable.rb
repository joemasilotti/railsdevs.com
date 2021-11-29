module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar
  end
end
