Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :professionals
      resources :schedules do
        resource :professional, only: [:show]
        resource :professional, only: [:show], path: 'relationships/professional'
      end
      resources :adresses do
        resource :professional, only: [:show]
        resource :professional, only: [:show], path: 'relationships/professional'
      end
    end
  end
end
