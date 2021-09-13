Rails.application.routes.draw do
  devise_for :users

  namespace :schedule do
    namespace :v1 do
      resources :professionals
      resources :schedules
    end
  end
end
