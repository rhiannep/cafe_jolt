class OrderItem < Sequel::Model
  many_to_one :order
  plugin :validation_helpers

  def validate
    super
    validates_presence [:quantity, :menu_item_id]
    quantity_cannot_be_greater_than_stock_level
  end

  def quantity_cannot_be_greater_than_stock_level
    if quantity.present? && quantity > current_stock_level
      errors.add(:quantity, "you ordered #{quantity}x #{menu_item_name} but there are only #{current_stock_level} left")
    end
  end

  def current_stock_level
    MenuItemFetcher.menu_item_for(menu_item_id).stock_level || 0
  end
end
