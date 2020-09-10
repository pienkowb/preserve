Rails.application.routes.draw do
  resources :parameters, only: %i[index create]

  namespace :admin do
    resources :parameters, only: :index
  end
end
