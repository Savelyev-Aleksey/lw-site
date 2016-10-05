class RenameNewsTableToActivitiesTable < ActiveRecord::Migration
  def change
    rename_table :news, :activities
  end
end
