class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
