Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get '/about' => "pages#about"
  get '/stimulus' => "pages#stimulus"

  resources :users do
    resource :tfa, only: [:new, :create, :show]
    resource :tfa_session, only: [:new, :create]
    resource :tfa_recovery, only: [:new, :create]
    resources :todos, only: [:index, :update]
  end

  get '/signup' => "users#new"

  resource :session

  get "/signin" => "sessions#new"

  # To handle creation of a new todo directly on the index page
  post "/todos" => "todos#create"
end
