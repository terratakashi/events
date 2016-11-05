require "rails_helper"

describe Event do

  it { should validate_presence_of :occasion }
  it { should validate_presence_of :date }
  it { should validate_presence_of :invited_count }

  describe "#title" do
    it "returns a string including occasion and invited number" do
      event = Event.create(occasion: "New Year Party", date: "2016-01-01", invited_count: 30)
      expect(event.title).to eq("New Year Party - 30 Invited")
    end

    it "returns a string including occasion, invited number and cancelled status if event got cancelled" do
      event = Event.create(occasion: "Final Exam", date: "2016-05-20", invited_count: 20, cancelled: true)
      expect(event.title).to eq("Cancelled: Final Exam - 20 Invited")
    end
  end
end
