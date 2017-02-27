class CreateHostels < ActiveRecord::Migration[5.0]
  def change
    create_table :hostels do |t|
      t.string :name
      t.text :description
      t.string :address
      t.text :information

      t.timestamps
    end
  end
end
