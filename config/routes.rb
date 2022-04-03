Rails.application.routes.draw do
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "products#index"

  resources :products, only: %i(index update)
  resources :item_total, only: %i(index)
  resources :discounts, only: %i(index)
end
