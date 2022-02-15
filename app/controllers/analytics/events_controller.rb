module Analytics
  class EventsController < ApplicationController
    def show
      event = Analytics::Event.find(params[:id])

      unless event.tracked?
        event.mark_as_tracked!
        flash[:event] = {goal: event.goal, value: event.value}
      end

      redirect_to event.url
    end
  end
end
