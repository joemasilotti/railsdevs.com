# frozen_string_literal: true

class TechStackComponent < ApplicationComponent
  def initialize(body)
    @body = body
  end

  def render?
    @body.present?
  end

  def body
    @body
  end
end
