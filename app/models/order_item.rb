class OrderItem < ApplicationRecord
  belongs_to :order

  validates :quantity, presence: true
  :menu_item_id
  validate :quantity_cannot_be_greater_than_stock_level

  def quantity_cannot_be_greater_than_stock_level
    if quantity.present? && quantity > current_stock_level
      errors.add(:quantity, "you ordered #{quantity}x #{name} but there are only #{current_stock_level} left")
    end
  end

  def current_stock_level
    MenuItemFetcher.stock_level(menu_item_id)
  end

  def name
    MenuItemFetcher.name(menu_item_id)
  end
end
