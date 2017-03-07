class RemoveTypeFromRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :type
  end
end
