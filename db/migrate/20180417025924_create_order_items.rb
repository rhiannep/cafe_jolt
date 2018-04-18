Sequel.migration do
  change do
    create_table :order_items do
      primary_key :id
      Integer :quantity
      String :menu_item_id
      String :menu_item_name
      foreign_key :order_id, :orders
    end
  end
end
