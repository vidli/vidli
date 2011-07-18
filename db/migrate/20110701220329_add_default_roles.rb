class AddDefaultRoles < ActiveRecord::Migration
  def self.up
    admin = Role.create(:title => 'Admin')
  end

  def self.down
    Role.find_by_title('Admin').destroy
  end
end
