Rails.application.routes.draw do
  root 'to_dos#index'
  
  resources :to_dos
  get 'to_dos/:id/finish', to: 'to_dos#finish', as: :finish_to_do
end
