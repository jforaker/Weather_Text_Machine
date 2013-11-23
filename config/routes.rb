WeatherTextMachine::Application.routes.draw do
  get "forecasts/index"
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  get 'user/:id' => 'forecasts#get_from_worldweatheronline'

  resources :texts
  resources :forecasts


end
