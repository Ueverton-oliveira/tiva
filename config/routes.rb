Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :professionals
      resources :schedules
      resources :adresses
    end
  end
end
