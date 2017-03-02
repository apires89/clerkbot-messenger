class AddQuikRepliesToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :quik_replies, :bool, null: false, default: true
  end
end
