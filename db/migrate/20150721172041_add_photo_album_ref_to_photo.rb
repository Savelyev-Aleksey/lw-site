class AddPhotoAlbumRefToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :photo_album, index: true
  end
end
