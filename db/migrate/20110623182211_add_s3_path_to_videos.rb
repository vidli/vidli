class AddS3PathToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :s3_path, :string
  end

  def self.down
    remove_column :videos, :s3_path
  end
end
