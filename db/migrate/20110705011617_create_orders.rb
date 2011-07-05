class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :purchased_at
      t.string :express_payer_id
      t.string :express_token
      t.integer :user_id
      t.string :ip
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_postal_code

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
