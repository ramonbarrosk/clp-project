Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :simulate_loan, only: [:index]
  resources :loan, only: [:index]
end
