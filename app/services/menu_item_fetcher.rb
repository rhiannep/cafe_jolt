module MenuItemFetcher
  include HTTParty
  base_uri "https://kitchen-service.herokuapp.com"

  def self.menu_items
    self.get("/menu_items").parsed_response["menu_items"]
  end

  def self.stock_level_for(menu_item_id)
    self.get("/menu_items/#{menu_item_id}").parsed_response["stock_level"]
  end

  def self.name_for(menu_item_id)
    self.get("/menu_items/#{menu_item_id}").parsed_response["name"]
  end
end
