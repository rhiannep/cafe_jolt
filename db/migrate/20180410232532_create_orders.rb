class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.timestamps
    end
  end
end
