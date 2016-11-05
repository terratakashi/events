class EventsController < ApplicationController
  def index
  end

  def new
  end

  def create_events
    events_json = JSON.parse(secure_params["json_body"])
    if events_json.has_key?("events")
      events_json["events"].each do |event|
        add_event(event)
      end
    end

    redirect_to events_path
  end

  def recent
    @events = Event.last 20
  end

  private

  def add_event(event)
    event_date = DateTime.new(event["year"], event["month"], event["day"])
    cancelled_status = event["cancelled"].present? ? event["cancelled"] : false
    Event.create(occasion: event["occasion"], date: event_date, invited_count: event["invited_count"], cancelled: cancelled_status)
  end

  def secure_params
    params.permit(:json_body)
  end
end
