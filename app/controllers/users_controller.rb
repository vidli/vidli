class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "Registration successful!"
      redirect_back_or_default account_url
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = current_user
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