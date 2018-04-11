Rails.application.routes.draw do
  resources :orders, only: [:create, :new] do
  end
  resources :menu_items, only: :index
end
