Rails.application.routes.draw do
  devise_for :users

  namespace :schedule do
    namespace :v1 do
      get "professional" => "professionals#index"
    end
  end
end
