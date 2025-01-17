Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users, only: [:destroy] do
          member do
            get 'suspend'
          end
        end
      end

      resources :users, only: [:index, :update] do
        collection do
          post 'search'
        end
      end
    end
  end
end
