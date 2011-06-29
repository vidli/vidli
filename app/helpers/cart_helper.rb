module CartHelper
  def get_cart
    cart = Cart.find_by_session_id(session[:session_id]) || Cart.new(:session_id => session[:session_id])
  end
  
  def cart_item_price(item, delivery)
    if delivery == 'streaming'
      item.video.price_streaming
    else
      item.video.price_download
    end
  end
end