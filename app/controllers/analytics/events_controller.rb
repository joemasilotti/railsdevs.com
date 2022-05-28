module Analytics
  class EventsController < ApplicationController
    def show
      event = Analytics::Event.find(params[:id])

      unless event.tracked?
        event.track!
        flash[:event] = {goal: event.goal, value: event.value}
      end

      flash.keep
      redirect_to event.url
    end
  end
end
