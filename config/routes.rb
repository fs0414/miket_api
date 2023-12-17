Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post 'signup', to: 'users#signup'
      post 'signin', to: 'users#signin'
      post 'signout', to: 'users#signout'

      resources :users, only: %i[index] do
        resources :categories, only: %i[index] do
          resources :items, only: %i[create update destroy]
        end
      end
    end
  end
end
