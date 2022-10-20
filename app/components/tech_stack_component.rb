# frozen_string_literal: true

class TechStackComponent < ApplicationComponent
  def initialize(body)
    @body = body
  end

  def render?
    @body.present?
  end

  attr_reader :body
end
