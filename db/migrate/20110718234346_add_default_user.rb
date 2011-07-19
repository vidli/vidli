class AddDefaultUser < ActiveRecord::Migration
  def self.up
    u = User.create(:first_name => 'Admin', :last_name => 'User', :email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
    u.roles << Role.find(:first)
  end

  def self.down
    u = User.find_by_email('admin@example.com')
    u.destroy
  end
end
