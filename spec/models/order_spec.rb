require "rails_helper"

describe Order do
  describe "#create" do
    it "commits a new order to the db" do
      allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)

      order_attributes = { order_items_attributes: [{ quantity: 1, menu_item_id: "menu_item_id"}]}
      expect { Order.create(order_attributes) }.to change{ Order.count }.by(1)
    end

    it "doesn't save if the stock level is too low" do
      allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)

      order_attributes = { order_items_attributes: [{ quantity: 2, menu_item_id: "menu_item_id"}]}
      expect { Order.create(order_attributes) }.not_to change{ Order.count }
    end

    it "has errors if the stock level is too low" do
      allow(MenuItemFetcher).to receive(:stock_level_for).and_return(1)

      order_attributes = { order_items_attributes: [{ quantity: 2, menu_item_id: "menu_item_id"}]}
      order = Order.create(order_attributes)

      expect(order.errors.any?).to be true
    end
  end
end
