Rails.application.routes.draw do
  devise_for :users

  # ポケモン図鑑ルート 📖
  resources :pokedex, only: [:index, :show] do
    collection do
      get :random
      get :search
    end
  end

  resources :challenges do
    resources :pokemons do
      member do
        patch :toggle_party
        patch :mark_as_dead
        patch :mark_as_boxed
      end
      collection do
        get :party
      end
    end

    resources :rules, except: [ :new, :create ] do
      collection do
        patch :update_multiple
        post :create_custom
        get :violations_check
      end
    end
  end

  # 統計ダッシュボード
  get "dashboard", to: "dashboard#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
