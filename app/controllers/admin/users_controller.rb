class Admin::UsersController < Admin::AdminController
  filter_access_to :all, :context => :admin_users
  
  def index
    @users = User.all.paginate :per_page => 10, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def update_roles
    @user = User.find(params[:id])
    
    # Add or remove any roles for the user
    params[:roles].each do |r|
      role = Role.find(r[0])
      role_exists = @user.roles.find_by_id(r[0])
      checked = r[1].to_i == 1 ? true : false
      
      if checked
        @user.roles << role unless role_exists
      else
        @user.roles.delete(role) unless !role_exists
      end
    end
    
    redirect_to :action => 'show'
  end
end
