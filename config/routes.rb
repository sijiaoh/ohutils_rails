Rails.application.routes.draw do
  root "static_pages#home"

  get "sign_in", to: "session#new"
  get "sign_up", to: "users#new"
  delete "sign_out", to: "session#destroy"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, param: :hashid, only: [:index, :show, :create]
  namespace :guests do
    resources :users, only: [:index, :new, :create]
  end

  resources :spaces, param: :hashid, shallow: true do
    resources :posts, param: :hashid
    resources :peer_reviews, param: :hashid, shallow: true do
      namespace :peer_reviews do
        resources :participations, param: :hashid
      end
    end
  end
end
