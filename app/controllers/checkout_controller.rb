class CheckoutController < ApplicationController
  before_filter :require_user
  
  def express
    response = EXPRESS_GATEWAY.setup_purchase(@cart.total_price,
      :ip                => request.remote_ip,
      :return_url        => confirm_checkout_url,
      :cancel_return_url => cart_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def confirm
    @order = Order.new(:express_token => params[:token])
    if !current_user.cart || current_user.cart.empty?
      flash[:error] = 'Your cart is empty'
      redirect_to root_url
    end
  end
  
  def place_order
    @order = Order.create_order_from_cart(current_user.cart, params[:order][:express_token])
    @order.ip = request.remote_ip
    @user = @order.user

    if @order.save
      if @order.purchase
        @user.cart.destroy 
        flash[:notice] = "Your Order Has Been Submitted"
#       @order.notify_video_buyer
#       @order.notify_video_seller
        redirect_to order_url(@order.uuid) and return
      else
        @order.destroy
        flash[:error] = "Sorry - your purchase failed. Please check your info and try again."
        redirect_to cart_path
      end
    else
      flash[:error] = @order.errors.collect { |e| '<p>' + e.to_s + '</p>' } 
      redirect_to cart_path
    end
  end

end
