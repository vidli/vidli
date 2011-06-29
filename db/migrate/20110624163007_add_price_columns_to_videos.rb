class AddPriceColumnsToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :price_streaming_in_cents, :integer
    add_column :videos, :price_download_in_cents, :integer
  end

  def self.down
    remove_column :videos, :price_streaming_in_cents
    remove_column :videos, :price_download_in_cents
  end
end