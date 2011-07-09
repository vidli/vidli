class AddUuidToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :uuid, :string
  end

  def self.down
    remove_column :orders, :uuid
  end
end
