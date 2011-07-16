class Video < ActiveRecord::Base
  scope :enabled, where("((videos.price_download_in_cents > 0 AND videos.downloadable = 1) OR (videos.price_streaming_in_cents > 0 AND videos.streamable = 1)) AND videos.s3_path IS NOT NULL")
  
  has_attached_file :screenshot, :styles => { :large => '640x480>', :medium => "400x300>", :thumb => "188x110>", :tiny => '100x100>' }
  
  composed_of :price_download,
    :class_name => "Money",
    :mapping => [%w(price_download_in_cents cents)],
    :constructor => Proc.new { |cents| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :price_streaming,
    :class_name => "Money",
    :mapping => [%w(price_streaming_in_cents cents)],
    :constructor => Proc.new { |cents| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  def s3_url
    "http://s3.amazonaws.com/#{S3SwfUpload::S3Config.bucket}/#{s3_path}"
  end
  
  def self.get_search_condition(search=nil)
    conditions = ["title like ?", "%#{search}%"] if search
  end
  
  def sold_to?(user, delivery)
    sold = nil
    order_uuid = nil
    order_item_id = nil
    
    return [sold, order_uuid, order_item_id] if !user
    
    order_item = user.order_items.find_by_video_id_and_delivery(self.id, delivery)
    
    if order_item
      sold = true
      order_item_id = order_item.id
      order_uuid = order_item.order.uuid
    end
    
    return [sold, order_uuid, order_item_id]
  end
  
  def enabled?
    ((price_download > 0.to_money && downloadable?) || (price_streaming > 0.to_money && streamable?)) && !s3_path.empty?
  end
end
