class AddUrlToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :url, :string
  end
end
