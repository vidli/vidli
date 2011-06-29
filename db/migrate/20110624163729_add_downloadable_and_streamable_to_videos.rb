class AddDownloadableAndStreamableToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :downloadable, :boolean
    add_column :videos, :streamable, :boolean
  end

  def self.down
    remove_column :videos, :downloadable
    remove_column :videos, :streamable
  end
end
