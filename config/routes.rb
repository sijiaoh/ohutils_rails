Rails.application.routes.draw do
  namespace :peer_reviews do
    resources :participations
  end
  root "static_pages#home"

  get "sign_in", to: "session#new"
  get "sign_up", to: "users#new"
  delete "sign_out", to: "session#destroy"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, param: :hashid, only: [:index, :show, :create]
  resources :spaces, param: :hashid, shallow: true do
    resources :posts, param: :hashid
    resources :peer_reviews, param: :hashid
  end
end
