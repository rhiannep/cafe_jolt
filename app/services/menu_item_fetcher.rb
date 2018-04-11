module MenuItemFetcher
  include HTTParty
  base_uri "https://kitchen-service.herokuapp.com"

  def self.menu_items
    self.get("/menu_items").parsed_response["menu_items"]
  end
end
