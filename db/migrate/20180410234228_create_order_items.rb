class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :menu_item_id
      t.integer :quantity
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
