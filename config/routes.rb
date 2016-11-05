Rails.application.routes.draw do

  resources :events, only: [:index, :new] do
    collection do
      get "recent"
    end
  end
  post "/events_json", to: "events#create_events"
  root to: "events#index"
end
