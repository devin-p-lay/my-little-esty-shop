Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :merchants, only: :show do
    resources :dashboard, only: :index
    resources :items, only: [:index, :show]
    resources :invoices, only: :index
  end
end
