class Cart < ActiveRecord::Base
  
  # Two kinds of carts. One for registered and another for sessions
  
  belongs_to :user
  has_many :cart_items, :dependent => :destroy

  # == VALIDATIONS
  validates_uniqueness_of :user_id, :allow_nil => true # only one cart per user
  validates_uniqueness_of :session_id, :allow_nil => true # only one cart per session
  def validate
    user_or_session_but_not_both?
  end
  
  # == CALLBACKS
  before_save :compact_cart!

  # can only have either a user cart or a session cart
  def user_or_session_but_not_both?
    errors.add(:session_id, 'cannot be set if user_id set') if (user_id.blank? == session_id.blank?)
  end
  
  def move_cart_items_from(cart2)
    cart2.cart_items.each {|i| self.cart_items << i}
  end

  # merge the deadcart into this one, then destroy it
  def merge_and_destroy!(deadcart)
    return if deadcart.blank? # return if no cart
    self.move_cart_items_from(deadcart) # move items
    self.save
    self.compact_cart! # compact the new cart
    deadcart.reload # reload the old cart, so it doesn't destroy the line items, when we destroy it 
    deadcart.destroy 
  end

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