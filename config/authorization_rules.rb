authorization do 
  role :admin do
    includes :guest
    has_permission_on :admin_videos, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :update_s3_path, :delete_s3_asset]
    has_permission_on :admin_orders, :to => [:index, :show]
  end
  
  role :registered do
    includes :guest
  end
  
  role :guest do
  end
end