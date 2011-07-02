module CartHelper
  def get_cart
    if current_user
      cart = Cart.find_by_user_id(current_user.id) || Cart.new(:user_id => current_user.id)
    else
      cart = Cart.find_by_session_id(session[:session_id]) || Cart.new(:session_id => session[:session_id])
    end
  end
  
  def cart_item_price(item, delivery)
    if delivery == 'streaming'
      item.video.price_streaming
    else
      item.video.price_download
    end
  end
  
  # for just /user_session/create
  # merges existing session and/or invitation carts into user cart. 
  # note that a successful login redirects, which will then call get_cart above. 
  def get_and_merge_cart(u)
    # get the session_id
    s_id = session[:session_id]

    # Find or create their cart
    cart = Cart.find_by_user_id(u.id) || Cart.new(:user_id => u.id)# find or create their cart
    
#    logger.info "Found or new cart for user #{u.id}: #{cart.inspect}"
    
    # Merge with an existing session cart
    dead_session_cart = Cart.find_by_session_id(s_id) 
    if dead_session_cart
      cart.merge_and_destroy!(dead_session_cart) 
#      logger.info "Merged user cart with session_id #{s_id}'s cart"
      cart.save
    end
  end
  
end