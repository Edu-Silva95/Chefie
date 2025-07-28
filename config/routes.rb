Rails.application.routes.draw do
  get "categories/show"
  devise_for :users

  root "pages#home"

  get "communities/index"
  get "courses/index"
  get "courses/show"
  get "favorites/index"
  get "recipes/index"
  get "recipes/show"
  get "recipes/new"
  get "recipes/edit"
  get "dashboard/index"
  get "pages/home"

  get 'dashboard', to: 'dashboard#index'
  get "/profile", to: "users#show", as: :profile
  get "categories/:name", to: "categories#show", as: :category

  get 'courses/show_all', to: 'courses#show_all', as: :all_courses

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :ratings, only: [:create]
  end

  resources :favorites, only: [:index, :create, :destroy]

  resources :courses, only: [:index, :show, :create, :edit, :update, :destroy] do
  resources :ratings, only: [:create]

  collection do
    get :show_all
  end

  member do
    get 'like', to: 'courses#like'
    get 'unlike', to: 'courses#unlike'
  end
end

  resources :posts, only: [:create, :destroy] do
    member do
      get :like
      get :unlike
    end
  end

  resources :communities, only: [:index, :show, :new, :create] do
    collection do
      get :search
    end

    resources :topics, only: [:create, :show, :new] do
      resources :replies, only: [:create] do
        resource :like, only: [:create, :destroy], controller: "reply_likes"
      end
    end
  end
end
