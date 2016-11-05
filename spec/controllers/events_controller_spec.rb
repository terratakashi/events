require "rails_helper"

describe EventsController do

  describe "GET #index" do
  end

  describe "GET #new" do
  end


  describe "POST #create_events" do
    context "with valid events input" do
      before do
        json = { events: [{occasion: "Birthday party", invited_count: 120, year: 2016, month: 2, day: 14 },
                          {occasion: "Chirstmas party", invited_count: 120, year: 2016, month: 12, day: 25 }]}.to_json
        post :create_events, json_body: json
      end

      it "create multiple events" do
        expect(Event.count).to eq(2)
      end

      it "redirect to events index page" do
        expect(response).to redirect_to events_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid events input" do
      before do
        json = { events: [{occasion: nil, invited_count: nil, year: 2016, month: 2, day: 14 },
                          {occasion: "Chirstmas party", invited_count: 120, year: 2016, month: 12, day: 25 }]}.to_json

        post :create_events, json_body: json
      end

      it "no event has been created" do
        expect(Event.count).to eq(0)
      end

      it "redirect to event new page" do
        expect(response).to redirect_to new_event_path
      end

      it "sets the flash error message" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET #recent" do
    it "sets @events" do
      next_new_year = Date.new(Date.today.next_year.year, 1, 1)
      last_chirstmas = Date.new(Date.today.last_year.year, 12, 25)

      new_year_event = Event.create(occasion: "New Year Party", date: next_new_year, invited_count: 30)
      chirstmas_event = Event.create(occasion: "Chirstmas Party", date: last_chirstmas, invited_count: 30)

      get :recent, format: :json
      expect(assigns(:events)).to match_array([new_year_event, chirstmas_event])
    end
  end
end
