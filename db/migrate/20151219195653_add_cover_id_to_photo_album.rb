class AddCoverIdToPhotoAlbum < ActiveRecord::Migration
  def change
    add_column :photo_albums, :cover_id, :integer
  end
end
