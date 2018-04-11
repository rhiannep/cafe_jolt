class MenuItemsController < ApplicationController
  def index
    @menu_items = MenuItemFetcher.menu_items
  end
end
