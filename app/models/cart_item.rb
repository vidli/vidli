class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :video
  
  def price
    return video.price_streaming if delivery == 'streaming'
    return video.price_download if delivery == 'download'
  end
end