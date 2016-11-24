class AddTechToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :tech, :boolean
  end
end
