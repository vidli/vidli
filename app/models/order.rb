class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :destroy
  has_many :transactions, :class_name => "OrderTransaction", :dependent => :destroy

  composed_of :total,
    :class_name => "Money",
    :mapping => [%w(total_in_cents cents)],
    :constructor => Proc.new { |cents| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }  
  
  
  # == VALIDATIONS
  validates_presence_of :user_id

  def purchase
    response = process_purchase
    transactions.create!(:action => "purchase", :total => total, :response => response)
    response.success?
  end
  
  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
    end
  end
  
  def Order.create_order_from_cart(cart, express_token)
    # create a new order
    new_order = Order.new(:user_id => cart.user_id, :express_token => express_token)
        
    cart.cart_items.each do |ci|
      # add this to OrderItem.build_from_line_item(li)
      new_oi = new_order.order_items.build(:video_id => ci.video_id, :delivery => ci.delivery, :price => ci.price)
    end
    
    new_order.update_order_total
    
    return new_order
  end
  
  def update_order_total
    self.total = 0.to_money
    order_items.each { |oi| self.total += oi.price }
  end
  
  private

  def process_purchase
    EXPRESS_GATEWAY.purchase(total, express_purchase_options)
  end

  def express_purchase_options
    {
      :ip => ip,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end
end
