class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :video_id
      t.string :delivery
    end
  end

  def self.down
    drop_table :cart_items
  end
end
