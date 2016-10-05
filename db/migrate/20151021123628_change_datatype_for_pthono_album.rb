class ChangeDatatypeForPthonoAlbum < ActiveRecord::Migration
  def change
    change_column :photo_albums, :description, :text
  end
end
