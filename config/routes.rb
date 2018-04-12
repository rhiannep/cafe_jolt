Rails.application.routes.draw do
  root "menu_items#index"
  resources :orders, only: [:create, :new]
  resources :menu_items, only: :index
end
