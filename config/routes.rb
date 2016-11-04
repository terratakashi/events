Rails.application.routes.draw do

  resources :events, only: [:index, :new]
end
