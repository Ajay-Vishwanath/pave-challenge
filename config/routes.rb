Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :employees, only: [:index]
  resources :salary, only: [:show]
  resources :bonus, only: [:show]
end
