class RemoveCategoryRefFromNews < ActiveRecord::Migration
  def change    
    remove_reference :news, :categoty
  end
end
