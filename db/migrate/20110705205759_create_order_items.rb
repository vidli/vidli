class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :video_id
      t.integer :price_in_cents
      t.string :delivery

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
