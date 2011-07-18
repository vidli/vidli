authorization do 
  role :admin do
    includes :guest
    has_permission_on :admin_videos, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :update_s3_path, :delete_s3_asset, :download, :stream]
    has_permission_on :admin_orders, :to => [:index, :show]
    has_permission_on :admin_users, :to => [:index, :show, :update_roles]
    has_permission_on :admin_s3uploads, :to => [:index]
  end
  
  role :guest do
  end
end