class OrderForm < Reform::Form
  collection :order_items do
    property :menu_item_id
    property :quantity
  end
end
