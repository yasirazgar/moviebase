# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'movies#index'
  scope format: true, constraints: { format: 'json' }, defaults: { format: :json } do

    post "login", to: "authentication#create", as: "login"
    post "signup", to: "users#create", as: "signup"
    resources :users, only: :create

    resources :movies, only: [:index, :update, :create, :update, :destroy] do
      collection do
        get :search
      end
      resources :ratings, only: [] do
        collection do
          patch :rate
        end
      end

    end
  end
end
