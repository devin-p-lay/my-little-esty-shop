Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index]
  end
end
