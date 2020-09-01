Rails.application.routes.draw do
  resources :parameters, only: [:index, :create]
end
