Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/customers/find", to: "customers/finder#show"
      get "/customers/find_all", to: "customers/finder#index"
      get "/customers/random", to: "customers/random#show"

      get "/invoice_items/find", to: "invoice_items/finder#show"
      get "/invoice_items/find_all", to: "invoice_items/finder#index"
      get "/invoice_items/random", to: "invoice_items/random#show"

      get "/invoices/find", to: "invoices/finder#show"
      get "/invoices/find_all", to: "invoices/finder#index"
      get "/invoices/random", to: "invoices/random#show"

      get "/items/find", to: "items/finder#show"
      get "/items/find_all", to: "items/finder#index"
      get "/items/random", to: "items/random#show"

      get "/merchants/find", to: "merchants/finder#show"
      get "/merchants/find_all", to: "merchants/finder#index"
      get "/merchants/random", to: "merchants/random#show"
      get "/merchants/:id/items", to: "merchants/items#index"
      get "/merchants/:id/invoices", to: "merchants/invoices#index"

      get "/transactions/find", to: "transactions/finder#show"
      get "/transactions/find_all", to: "transactions/finder#index"
      get "/transactions/random", to: "transactions/random#show"

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
