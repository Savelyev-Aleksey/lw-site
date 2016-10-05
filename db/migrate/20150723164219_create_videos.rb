class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :description
      t.references :video_album, index: true

      t.timestamps
    end
  end
end
