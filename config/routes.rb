Rails.application.routes.draw do
  # Configuration Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  # Pages statiques
  get "static_pages/index"
  get "static_pages/secret"

  # Ressources utilisateurs
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  # PWA
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Ressources événements
  resources :events do
    resources :attendees, only: [:index, :create, :destroy]
  end

  # Définir la page d'accueil
  root "events#index"
  
scope '/checkout' do
  post '/create-checkout-session', to: 'payments#create_checkout_session'
  get '/success', to: 'payments#success'
  get '/cancel', to: 'payments#cancel'
end

  # Vérification de l'état de santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check
end