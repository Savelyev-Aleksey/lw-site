class CreateVideoAlbums < ActiveRecord::Migration
  def change
    create_table :video_albums do |t|
      t.string :title
      t.string :text
      t.timestamp :date
      t.references :video, index: true

      t.timestamps
    end
  end
end
