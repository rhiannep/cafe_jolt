Rails.application.routes.draw do
  root "menu_items#index"
  resources :orders
  resources :menu_items, only: :index
end
