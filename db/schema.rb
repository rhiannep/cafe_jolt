Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id
      column :uuid, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()")
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:order_items) do
      primary_key :id
      column :quantity, "integer"
      column :menu_item_id, "text"
      column :menu_item_name, "text"
      foreign_key :order_id, :orders, :key=>[:id]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180417024814_create_orders.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20180417025924_create_order_items.rb')"
                end
              end
