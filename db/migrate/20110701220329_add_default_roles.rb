class AddDefaultRoles < ActiveRecord::Migration
  def self.up
    admin = Role.create(:title => 'Admin')
    reg = Role.create(:title => 'Registered')
  end

  def self.down
    Role.find_by_title('Admin').destroy
    Role.find_by_title('Registered').destroy
  end
end
