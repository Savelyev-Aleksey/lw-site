class AddCategoryRefToNews < ActiveRecord::Migration
  def change
    add_reference :news, :category, index: true
    add_foreign_key :news, :categories
  end
end
