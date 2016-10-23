class AddDatesToPhotoAlbums < ActiveRecord::Migration[5.0]
  def change
    add_column :photo_albums, :start_date, :date
    add_column :photo_albums, :end_date, :date
  end
end
