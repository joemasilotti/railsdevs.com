# From https://gorails.com/episodes/devise-hotwire-turbo
# This enables the default turbo stream responses to work with devise.
# This can be removed once devise is updated to properly support Turbo.
module Turbo
  class DeviseController < ApplicationController
    class Responder < ActionController::Responder
      def to_turbo_stream
        controller.render(options.merge(formats: :html))
      rescue ActionView::MissingTemplate => error
        if get?
          raise error
        elsif has_errors? && default_action
          render rendering_options.merge(formats: :html, status: :unprocessable_entity)
        else
          redirect_to navigation_location
        end
      end
    end

    self.responder = Responder
    respond_to :html, :turbo_stream
  end
end
