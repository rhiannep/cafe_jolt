class MenuItemFetcher
  include HTTParty
  base_uri "https://kitchen-service.herokuapp.com"

  def self.menu_items
    MenuItem.parse_kitchen_response(self.get("/menu_items"))
  end

  def self.menu_item_for(menu_item_id)
    MenuItem.new(self.get("/menu_items/#{menu_item_id}"))
  end
end
