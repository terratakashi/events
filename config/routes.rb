Rails.application.routes.draw do

  resources :events, only: [:index, :new]

  post "/events_json", to: "events#create_events"
end
