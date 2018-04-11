describe MenuItemFetcher do
  describe "#menu_items" do
    it "calls the external api" do
      MenuItemFetcher.menu_items
      expect(MenuItemFetcher).to receive(:get).with("/menu_items")
    end
  end
end
