class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.timestamp :date
      t.text :text

      t.timestamps
    end
  end
end
