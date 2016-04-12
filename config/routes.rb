Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/customers/find", to: "customers/finder#show"
      get "/customers/find_all", to: "customers/finder#index"

      get "/invoice_items/find", to: "invoice_items/finder#show"
      get "/invoice_items/find_all", to: "invoice_items/finder#index"

      get "/invoices/find", to: "invoices/finder#show"
      get "/invoices/find_all", to: "invoices/finder#index"

      get "/items/find", to: "items/finder#show"
      get "/items/find_all", to: "items/finder#index"

      get "/merchants/find", to: "merchants/finder#show"
      get "/merchants/find_all", to: "merchants/finder#index"

      get "/transactions/find", to: "transactions/finder#show"
      get "/transactions/find_all", to: "transactions/finder#index"

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
