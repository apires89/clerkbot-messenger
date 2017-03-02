class AddLocationToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :location, :string
  end
end
