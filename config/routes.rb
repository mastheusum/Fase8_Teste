Rails.application.routes.draw do
  
  devise_for :users, controllers: { sessions: "api/v1/sessions" }

  namespace :api, defaults: { format: :json } do
    namespace :v1, path: "/" do
      resources :users
      resources :sessions
    end
  end
end
