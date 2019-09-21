Rails.application.routes.draw do
  post "signup", to: "users#create", as: "signup"
  resources :users, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
