Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :to_dos
  get 'to_dos/:id/finish', to: 'to_dos#finish', as: :finish_to_do
  get 'to_dos/:id/unfinish', to: 'to_dos#unfinish', as: :unfinish_to_do
end
