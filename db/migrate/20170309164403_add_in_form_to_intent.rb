class AddInFormToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :in_form, :bool, null: false, default: true
  end
end
