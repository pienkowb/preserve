Rails.application.routes.draw do
  resources :parameters, only: %i[index create]
end
