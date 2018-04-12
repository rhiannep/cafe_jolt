describe MenuItemFetcher do
  describe "#menu_items" do
    it "calls the external api" do
      allow(MenuItemFetcher)
        .to receive_message_chain(:get, :parsed_response, :[])
      MenuItemFetcher.menu_items
      expect(MenuItemFetcher).to have_received(:get).with("/menu_items")
    end
  end

  describe "#stock_level_for" do
    it "calls the external api" do
      allow(MenuItemFetcher)
        .to receive_message_chain(:get, :parsed_response, :[])
      MenuItemFetcher.stock_level_for("menu_item_id")
      expect(MenuItemFetcher).to have_received(:get).with("/menu_items/menu_item_id")
    end
  end

  describe "#stock_level_for" do
    it "calls the external api" do
      allow(MenuItemFetcher)
        .to receive_message_chain(:get, :parsed_response, :[])
      MenuItemFetcher.name_for("menu_item_id")
      expect(MenuItemFetcher).to have_received(:get).with("/menu_items/menu_item_id")
    end
  end
end
