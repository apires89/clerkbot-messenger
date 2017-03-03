class RemoveIntentFromAnswer < ActiveRecord::Migration[5.0]
  def change
    remove_reference :answers, :intent, foreign_key: true
  end
end
