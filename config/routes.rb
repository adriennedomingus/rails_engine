Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/customers/find", to: "customers/finder#show"
      get "/invoice_items/find", to: "invoice_items/finder#show"
      get "/invoices/find", to: "invoices/finder#show"
      get "/items/find", to: "items/finder#show"
      get "/merchants/find", to: "merchants/finder#show"
      get "/transactions/find", to: "transactions/finder#show"
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
