Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get /about , the path for this is about_path (automatically generate by rails)
  # get "about", to: "about#index"

  # get /about-us, the path for this is about_path (using `as` here) as well.
  get "about-us", to: "about#index", as: :about

  # for root can either write get "/" or root directly
    # get "/", to: "main#index"
  root to: "main#index"


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
