class AddConstraintToTables < ActiveRecord::Migration[5.0]
  def change
    remove_index :pages, :symlink
    add_index :pages, :symlink, unique: true
    add_index :pages, :title, unique: true
    add_index :categories, :title, unique: true
  end
end
