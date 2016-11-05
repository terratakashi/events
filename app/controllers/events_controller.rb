class EventsController < ApplicationController
  def index
  end

  def new
  end

  def create_events
    begin
      events_json = JSON.parse(secure_params["json_body"])
      # TODO: Refactor json check with Ruby JSON Schema Validator
      if events_json.has_key?("events")
        begin
          ActiveRecord::Base.transaction do
            events_json["events"].each do |event|
              add_event(event)
            end
          end
          flash[:success] = "Events have been imported successfully!"
          redirect_to events_path
        rescue ActiveRecord::RecordInvalid
          flash[:error] = "JSON with invalid attributes!"
          redirect_to new_event_path
        end
      else
        flash[:error] = "JSON with invalid attributes!"
        redirect_to new_event_path
      end
    rescue JSON::ParserError
      flash[:error] = "Input JSON Error!"
      redirect_to new_event_path
    end
  end

  def recent
    @events = Event.where("date > ? AND date < ?", Date.today.last_year.beginning_of_year, Date.today.next_year.end_of_year)
  end

  private

  def add_event(event)
    event_date = DateTime.new(event["year"], event["month"], event["day"])
    cancelled_status = event["cancelled"].present? ? event["cancelled"] : false
    Event.create!(occasion: event["occasion"], date: event_date, invited_count: event["invited_count"], cancelled: cancelled_status)
  end

  def secure_params
    params.permit(:json_body)
  end
end
