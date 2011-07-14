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
  
  def reset_password
    @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise Exception)
  end

  def reset_password_submit
    @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise Exception)

    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully reset password."
      redirect_to account_path
    else
      flash[:error] = "There was a problem resetting your password."
      render :action => :reset_password
    end
  end
end