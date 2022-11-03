Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1, path: "/" do
      resources :users
    end
  end
  # devise_for :users
end
