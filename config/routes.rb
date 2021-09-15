Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :professionals
      resources :schedules do
        resource :professional, only: [:show]
      end
      resources :adresses do
        resource :professional, only: [:show]
      end
    end
  end
end
