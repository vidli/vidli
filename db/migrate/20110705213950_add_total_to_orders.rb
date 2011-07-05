class AddTotalToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :total_in_cents, :integer
  end

  def self.down
    remove_column :orders, :total_in_cents
  end
end
