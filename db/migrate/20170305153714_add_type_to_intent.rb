class AddTypeToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :type, :string
  end
end
