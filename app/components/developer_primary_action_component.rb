# frozen_string_literal: true

class DeveloperPrimaryActionComponent < ApplicationComponent
  def initialize(user:, developer:)
    @user = user
    @developer = developer
  end

  def owner?
    @user&.developer == @developer && !@developer.nil?
  end

  def business?
    @user&.business&.persisted?
  end
end
