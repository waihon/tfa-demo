Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get '/about' => "pages#about"

  resources :users

  get '/signup' => "users#new"

  resource :session

  get "/signin" => "sessions#new"
end
