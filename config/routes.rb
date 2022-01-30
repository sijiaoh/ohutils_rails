Rails.application.routes.draw do
  root "static_pages#home"

  get "sign_in", to: "sessions#new"
  get "sign_up", to: "users#new"
  delete "sign_out", to: "sessions#destroy"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, param: :hashid, only: %i[index show create]
  namespace :students do
    resources :users, only: %i[index new create]
  end

  resources :spaces, param: :hashid, shallow: true do
    resources :posts, param: :hashid
    resources :peer_reviews, param: :hashid, shallow: true do
      namespace :peer_reviews do
        resources :participations, param: :hashid
        resources :reviews, param: :hashid
        resource :result, only: [:show]
      end
    end
  end
end
