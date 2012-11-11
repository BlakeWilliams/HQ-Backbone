HQ::Application.routes.draw do
  resources :projects do
    resources :issues
  end
  root to: "home#index"
end
