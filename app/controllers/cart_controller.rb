class CartController < ApplicationController
  def index
  end
  
  def add
    @video = Video.find(params[:id])
    
    if ['streaming', 'download'].include?(params[:delivery])
      @cart.cart_items << CartItem.new(:video => @video, :delivery => params[:delivery])
    end
    
    if @cart.save!
      redirect_to :action => "index"
    else
      flash[:error] = "Error adding video license to cart!"
      redirect_to show_video(@video.id)
    end
  end
  
  def remove
    @cart_item = CartItem.find(params[:id])

    if @cart_item.destroy
      redirect_to :action => "index"
    else
      flash[:error] = "Error removing video license from cart!"
      redirect_to :action => "index"
    end
  end
end