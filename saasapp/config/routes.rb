Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  #get 'login', to: 'devise/sessions#new', as: 'new_user_session'
  #get 'sign-up', to: 'devise/registrations#new', as: 'new_user_registration'
end
