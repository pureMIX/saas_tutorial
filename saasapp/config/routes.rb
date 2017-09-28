Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users do
    resource :profile
  end
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  #get 'login', to: 'devise/sessions#new', as: 'new_user_session'
  #get 'sign-up', to: 'devise/registrations#new', as: 'new_user_registration'
end
