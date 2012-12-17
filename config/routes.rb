HQ::Application.routes.draw do

  post 'login', to: 'sessions#create'

  resources :projects do
    resources :issues
  end

  resources :issues do
    resources :comments
  end

  root to: "home#index"
end
