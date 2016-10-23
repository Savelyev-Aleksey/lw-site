class ChangeColumnInActivities < ActiveRecord::Migration[5.0]
  def change
    change_column :activities, :date, :date
  end
end
