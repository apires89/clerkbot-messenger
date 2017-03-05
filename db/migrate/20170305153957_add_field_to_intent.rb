class AddFieldToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :field, :string
  end
end
