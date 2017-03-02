class AddTitleToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :title, :string
  end
end
