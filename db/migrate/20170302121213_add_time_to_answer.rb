class AddTimeToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :time, :string
  end
end
