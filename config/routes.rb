Rails.application.routes.draw do
  resources :accounts do
    resources :comments
  end
end
