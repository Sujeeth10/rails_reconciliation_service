Rails.application.routes.draw do
  resources :transactions, only: [:index, :create] do
    collection do
      get :reconcile
    end
  end
  root to: 'transactions#index'
end
