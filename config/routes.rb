# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'home#index'
  resources :home, only: :index

  scope format: true, constraints: { format: 'json' }, defaults: { format: :json } do

    post "login", to: "authentication#create", as: "login"
    resources :users, only: :create
    resources :categories, only: :index
    resources :ratings, only: :index

    resources :movies, only: [:index, :update, :create, :update, :destroy] do
      collection do
        get :search
      end
      resources :ratings, controller: 'movies/ratings' ,only: [] do
        collection do
          patch :rate
        end
      end

    end
  end
end
