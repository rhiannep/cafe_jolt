class OrderItem < ApplicationRecord
  belongs_to :order

  validates :quantity, presence: true
  :menu_item_id
end
