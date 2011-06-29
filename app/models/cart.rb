class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy

  validates_uniqueness_of :session_id, :allow_nil => true # only one cart per session

  # == CALLBACKS
  before_save :compact_cart!

  # Remove any cart items of the same video and delivery
  # called when combining carts (anon w/ user or invite), and when adding any items to the cart
  def compact_cart!
    return if cart_items.length <= 1
    
    cart_items.each do |ci|
      # skip over any line items already removed (aka frozen)
      next if ci.frozen?
      
      # get all items that exist (not frozen), are not this item, are of the same license, and the same delivery method
      dup_items = cart_items.select { |dup| !dup.frozen? && dup.id != ci.id && dup.video_id == ci.video_id && dup.delivery == ci.delivery }
      
      # remove the duplicates
      dup_items.each { |dup| dup.destroy }
    end
  end

  def empty?
    self.cart_items.blank?
  end
end