class Video < ActiveRecord::Base
  has_attached_file :screenshot, :styles => { :large => '640x480>', :medium => "300x300>", :thumb => "188x110>" }
  
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
end
