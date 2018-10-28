Rails.application.routes.draw do
  resources :user_years
  resources :users
  resources :income_taxes
  resources :kosei_grades
  resources :kenpo_grades
  resources :systems
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
