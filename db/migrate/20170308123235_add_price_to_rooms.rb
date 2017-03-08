class AddPriceToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :price, :float
  end
end
