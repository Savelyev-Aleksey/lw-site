class AddPhotoAlbumsRefToActivities < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :photo_album, foreign_key: true
  end
end
