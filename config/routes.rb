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

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  # password reset page
  get "password/reset", to: "password_resets#new"
  # password reset action
  post "password/reset", to: "password_resets#create"

  # password reset edit page
  get "password/reset/edit", to: "password_resets#edit"
  # password reset update action
  patch "password/reset/edit", to: "password_resets#update"

  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"

  # the below line will automatically generate the paths for CRUD operations in relation to twitter_accounts model
  # it will also set the controller (to: "twitter_accounts" which links to twitter_accounts_controller.rb) for these paths to as twitter_controller
  resources :twitter_accounts
  # The following routes were generate by resources
  # | GET | /twitter_accounts | index | List all Twitter accounts |
  # | GET | /twitter_accounts/new | new | Show form to create a new account |
  # | POST | /twitter_accounts | create | Create a new Twitter account |
  # | GET | /twitter_accounts/:id | show | Show a specific Twitter account |
  # | GET | /twitter_accounts/:id/edit| edit | Show form to edit an account |
  # | PATCH/PUT | /twitter_accounts/:id | update | Update a specific Twitter account |
  # | DELETE | /twitter_accounts/:id | destroy | Delete a specific Twitter account |
  # we don't need to implement all the routes in controller, we can be selective and choose which ones we want to.


  resources :tweets

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
