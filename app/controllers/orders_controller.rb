class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :require_owner
  
  def show
  end
  
  def download
    @video = @order.order_items.find(params[:order_item_id]).video
    
    AWS::S3::Base.establish_connection!(
      :access_key_id     => S3SwfUpload::S3Config.access_key_id, 
      :secret_access_key => S3SwfUpload::S3Config.secret_access_key
    )

    redirect_to AWS::S3::S3Object.url_for(@video.s3_path, S3SwfUpload::S3Config.bucket, :expires_in => 3600, :use_ssl => false)
  end
  
  def watch
  end

private

  def require_owner
    @order = Order.find_by_uuid(params[:id])
    
    # Check if the order is found at all
    if !@order
      flash[:error] = 'Order not found'
      redirect_to root_url
    end

    # If this isn't the owner, send 'em home
    if @order.user != current_user
      flash[:error] = 'You are not authorized'
      redirect_to root_url
    end
  end
end