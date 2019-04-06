Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get '/about' => "pages#about"

  resources :users do
    resource :tfa, only: [:new, :create, :show]
    resource :tfa_session, only: [:new, :create]
  end

  get '/signup' => "users#new"

  resource :session

  get "/signin" => "sessions#new"
end
