class AddCoordinatesToHostels < ActiveRecord::Migration[5.0]
  def change
    add_column :hostels, :latitude, :float
    add_column :hostels, :longitude, :float
  end
end
