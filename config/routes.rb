Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get "/forecast", to: "weather#index"
      get "/backgrounds", to: "image#index"
      post '/users', to: "users#create"
      post "/sessions", to: "sessions#create"
      post "/road_trip",to: "road_trip#create"
      get '/munchies', to: "munchies#index"
    end
  end
end
