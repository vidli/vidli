class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  
  def index
    redirect_to root_path
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "Registration successful!"
      
      # deliver notification
      UserMailer.deliver_signup_notification(@user)
      
      redirect_back_or_default account_path
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = current_user
  end
  

end